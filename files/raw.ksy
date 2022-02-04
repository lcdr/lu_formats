meta:
  id: raw
  file-extension: raw
  endian: le
  imports:
    - ../common/common
seq:
  - id: version
    type: u2
  - id: dev
    type: u1
  - id: num_chunks
    type: u4
    if: dev == 0
  - id: num_chunks_width
    type: u4
    if: dev == 0
  - id: num_chunks_height
    type: u4
    if: dev == 0
  - id: chunks
    type: chunk
    repeat: expr
    repeat-expr: num_chunks
    if: dev == 0
types:
  chunk:
    seq:
      - id: id
        type: u4
      - id: width
        type: u4
      - id: height
        type: u4
      - id: offset_world_x
        type: f4
      - id: offset_world_z
        type: f4
      - id: shader_id
        type: u4
        if: _root.version < 32
      - id: texture_ids
        type: u4
        repeat: expr
        repeat-expr: 4
      - id: density
        type: f4
      - id: height_map
        type: f4
        repeat: expr
        repeat-expr: width * height
      - id: diffuse_res
        type: u4
        if: _root.version >= 32
      - id: diffuse_res_pixels
        size: diffuse_res * diffuse_res * 4
        if: _root.version >= 32
        doc: RGBA
      - id: unknown1
        type: u1
        repeat: eos
        if: _root.version < 32
        doc: todo
      - id: diffuse_map_dds_size
        type: u4
        if: _root.version >= 32
      - id: diffuse_map_dds
        size: diffuse_map_dds_size
        if: _root.version >= 32
      - id: blend_res
        type: u4
      - id: blend_pixels
        size: blend_res * blend_res * 4
      - id: bits
        type: u1
        if: _root.version >= 32
      - id: blend_map_dds_size
        type: u4
        if: _root.version >= 32
      - id: blend_map_dds
        size: blend_map_dds_size
        if: _root.version >= 32
      - id: num_flairs
        type: u4
      - id: flairs
        type: flair_attributes
        size: 36
        repeat: expr
        repeat-expr: num_flairs
      - id: scene_map
        size: diffuse_res * diffuse_res
        if: _root.version >= 32
      - id: unknown2
        type: u1
        repeat: eos
        if: _root.version < 32
        doc: todo
      - id: vert_size
        type: u4
        if: _root.version >= 32
      - id: mesh_vert_usage
        type: u2
        repeat: expr
        repeat-expr: vert_size
      - id: mesh_vert_size
        type: u2
        repeat: expr
        repeat-expr: 16
      - id: mesh_tri
        type: mesh_tri
        repeat: expr
        repeat-expr: 16

  flair_attributes:
    seq:
      - id: id
        type: u4
      - id: scale_factor
        type: f4
      - id: pos
        type: common::vector3
      - id: rot
        type: common::vector3
      - id: color_r
        type: u1
      - id: color_g
        type: u1
      - id: color_b
        type: u1
  mesh_tri:
    seq:
      - id: mesh_tri_list_size
        type: u2
      - id: mesh_tri_list
        type: u2
        repeat: expr
        repeat-expr: mesh_tri_list_size
