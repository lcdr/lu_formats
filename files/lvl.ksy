meta:
  id: lvl
  file-extension: lvl
  endian: le
  imports:
    - ../common/common
seq:
  - id: fib_chunk
    type: fib_chunk
types:
  chunk:
    seq:
      - id: header
        contents: "CHNK"
      - id: type
        type: u4
        enum: chunk_type
      - id: header_version
        type: u2
      - id: data_version
        type: u2
      - id: size
        type: u4
      - id: data_offset
        type: u4
    instances:
      data:
        pos: data_offset
        type:
          switch-on: type
          cases:
            chunk_type::fib: fib_data
            chunk_type::environment: environment_data
            chunk_type::object: object_data
            chunk_type::particle: particle_data
  fib_chunk:
    seq:
      - id: header
        contents: "CHNK"
      - id: type
        contents: [0xe8, 0x03, 0x00, 0x00]
      - id: header_version
        type: u2
      - id: data_version
        type: u2
      - id: size
        type: u4
      - id: data_offset
        type: u4
    instances:
      data:
        pos: data_offset
        type: fib_data
  fib_data:
    seq:
      - id: version
        type: u4
      - id: revision
        type: u4
      - id: ofs_environment_chunk
        type: u4
      - id: ofs_object_chunk
        type: u4
      - id: ofs_particle_chunk
        type: u4
    instances:
      environment_chunk:
        pos: ofs_environment_chunk
        type: chunk
        if: ofs_environment_chunk != 0
      object_chunk:
        pos: ofs_object_chunk
        type: chunk
        if: ofs_object_chunk != 0
      particle_chunk:
        pos: ofs_particle_chunk
        type: chunk
        if: ofs_particle_chunk != 0
  environment_data:
    seq:
      - id: ofs_lighting
        type: u4
      - id: ofs_skydome
        type: u4
      - id: ofs_editor_settings
        type: u4
    instances:
      lighting_info:
        pos: ofs_lighting
        type: lighting_info
      skydome_info:
        pos: ofs_skydome
        type: skydome_info
      editor_settings:
        pos: ofs_editor_settings
        type: editor_settings
        if: _root.fib_chunk.data.version >= 37
  lighting_info:
    seq:
      - id: blend_time
        type: f4
        if: _root.fib_chunk.data.version >= 45
      - id: ambient
        type: f4
        repeat: expr
        repeat-expr: 3
      - id: specular
        type: f4
        repeat: expr
        repeat-expr: 3
      - id: upper_hemi
        type: f4
        repeat: expr
        repeat-expr: 3
      - id: position
        type: common::vector3
      - id: min_draw_distances
        type: scene_draw_distances
        if: _root.fib_chunk.data.version >= 39
      - id: max_draw_distances
        type: scene_draw_distances
        if: _root.fib_chunk.data.version >= 39
      - id: cull_data
        type: cull_data
        if: _root.fib_chunk.data.version >= 40
      - id: fog_near
        type: f4
        if: _root.fib_chunk.data.version >= 31 and _root.fib_chunk.data.version < 39
      - id: fog_far
        type: f4
        if: _root.fib_chunk.data.version >= 31 and _root.fib_chunk.data.version < 39
      - id: fog_color
        type: f4
        repeat: expr
        repeat-expr: 3
        if: _root.fib_chunk.data.version >= 31
      - id: dir_light
        type: f4
        repeat: expr
        repeat-expr: 3
        if: _root.fib_chunk.data.version >= 36
      - id: start_position
        type: common::vector3
        if: _root.fib_chunk.data.version < 42
      - id: start_rotation
        type: common::quaternion
        if: _root.fib_chunk.data.version >= 33 and _root.fib_chunk.data.version < 42
  scene_draw_distances:
    seq:
      - id: fog_near
        type: f4
      - id: fog_far
        type: f4
      - id: post_fog_solid
        type: f4
      - id: post_fog_fade
        type: f4
      - id: static_object_distance
        type: f4
      - id: dynamic_object_distance
        type: f4
  cull_data:
    seq:
      - id: num_cull_vals
        type: u4
      - id: cull_vals
        type: cull_val
        repeat: expr
        repeat-expr: num_cull_vals
  cull_val:
    seq:
      - id: group_id
        type: u4
      - id: min
        type: f4
      - id: max
        type: f4
  skydome_info:
    seq:
      - id: filename
        type: common::u4_str
      - id: sky_layer_filename
        type: common::u4_str
        if: _root.fib_chunk.data.version >= 34
      - id: ring_layer_0_filename
        type: common::u4_str
        if: _root.fib_chunk.data.version >= 34
      - id: ring_layer_1_filename
        type: common::u4_str
        if: _root.fib_chunk.data.version >= 34
      - id: ring_layer_2_filename
        type: common::u4_str
        if: _root.fib_chunk.data.version >= 34
      - id: ring_layer_3_filename
        type: common::u4_str
        if: _root.fib_chunk.data.version >= 34
  editor_settings:
    seq:
      - id: chunk_size
        type: u4
      - id: num_saved_colors
        type: u4
      - id: saved_colors
        type: color
        repeat: expr
        repeat-expr: num_saved_colors
  color:
    seq:
      - id: r
        type: f4
      - id: g
        type: f4
      - id: b
        type: f4
  object_data:
    seq:
      - id: num_objects
        type: u4
      - id: objects
        type: object_info
        repeat: expr
        repeat-expr: num_objects
  object_info:
    seq:
      - id: object_id
        type: common::object_id
      - id: lot
        type: common::lot
      - id: obj_type
        type: u4
        enum: node_type
        if: _root.fib_chunk.data.version >= 38
      - id: glom_id
        type: u4
        if: _root.fib_chunk.data.version >= 32
      - id: position
        type: common::vector3
      - id: rotation
        type: common::quaternion_wxyz
      - id: scale
        type: f4
      - id: config_size
        type: u4
      - id: config
        size: config_size * 2
      - id: render_technique
        type: render_technique
        if: _root.fib_chunk.data.version >= 7
  render_technique:
    seq:
      - id: num_render_attrs
        type: u4
      - id: name
        type: strz
        encoding: ascii
        size: 64
        if: num_render_attrs > 0
      - id: render_attrs
        type: render_attr
        repeat: expr
        repeat-expr: num_render_attrs
  render_attr:
    seq:
      - id: name
        type: strz
        encoding: ascii
        size: 64
      - id: num_floats
        type: u4
      - id: is_color
        type: common::bool
      - id: floats
        type: f4
        repeat: expr
        repeat-expr: 4
  particle_data:
    seq:
      - id: num_particles
        type: u4
      - id: particles
        type: particle
        repeat: expr
        repeat-expr: num_particles
  particle:
    seq:
      - id: priority
        type: u2
        if: _root.fib_chunk.data.version >= 43
      - id: position
        type: common::vector3
      - id: rotation
        type: common::quaternion_wxyz
      - id: effect_names
        type: common::u4_wstr
      - id: null_terminator
        contents: [0x00, 0x00]
        if: _root.fib_chunk.data.version < 46
      - id: config_data
        type: common::u4_wstr
enums:
  chunk_type:
    1000: fib
    2000: environment
    2001: object
    2002: particle
  node_type:
    0: environment_obj
    1: building
    2: enemy
    3: npc
    4: rebuilder
    5: spawned
    6: cannon
    7: bouncer
    8: exhibit
    9: moving_platform
    10: springpad
    11: sound
    12: particle
    13: generic_placeholder
    14: error_marker
    15: player_start
