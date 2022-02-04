meta:
  id: g
  file-extension: g
  endian: le
  bit-endian: le
  imports:
    - ../common/common
seq:
  - id: header
    contents: "10GB"
  - id: num_vertices
    type: u4
  - id: num_indices
    type: u4
  - id: has_texture_coords
    type: b1
  - id: has_normals
    type: b1
  - id: has_bone_weights
    type: b1
  - id: has_connectivity_dependent_faces
    type: b1
  - id: has_packed_round_edge_data
    type: b1
  - id: has_packed_average_normals
    type: b1
  - id: padding
    size: 3
  - id: vertices
    type: common::vector3
    repeat: expr
    repeat-expr: num_vertices
  - id: normals
    type: common::vector3
    repeat: expr
    repeat-expr: num_vertices
    if: has_normals
  - id: texture_coords
    type: common::vector2
    repeat: expr
    repeat-expr: num_vertices
    if: has_texture_coords
  - id: indices
    type: u4
    repeat: expr
    repeat-expr: num_indices
  - id: packed_round_edge_data
    type: packed_round_edge_data
    if: has_packed_round_edge_data
  - id: packed_average_normals
    type: packed_average_normals
    if: has_packed_average_normals
  - id: bone_weights
    type: bone_weights
    if: has_bone_weights
  - id: connectivity_dependent_faces
    type: connectivity_dependent_faces
    if: has_connectivity_dependent_faces
types:
  packed_round_edge_data:
    seq:
      - id: num_packed_round_edge_data
        type: u4
      - id: packed_round_edge_data
        type: f4
        repeat: expr
        repeat-expr: num_packed_round_edge_data
      - id: packed_round_edge_indices
        type: u4
        repeat: expr
        repeat-expr: _root.num_indices
  packed_average_normals:
    seq:
      - id: num_packed_average_normals
        type: u4
      - id: packed_average_normals
        type: common::vector3
        repeat: expr
        repeat-expr: num_packed_average_normals
      - id: packed_average_normal_indices
        type: u4
        repeat: expr
        repeat-expr: _root.num_indices
  bone_weights:
    seq:
      - id: weights_stream_size
        type: u4
      - id: weights_stream
        type: weights_stream
        size: weights_stream_size
      - id: weights_lookup
        type: u4
        repeat: expr
        repeat-expr: _root.num_vertices
  weights_stream:
    seq:
      - id: vertex_weights
        type: vertex_weight
        repeat: eos
  vertex_weight:
    seq:
      - id: num_bone_weights
        type: u4
      - id: bone_weights
        type: bone_weight
        repeat: expr
        repeat-expr: num_bone_weights
  bone_weight:
    seq:
      - id: bone_index
        type: u4
      - id: weight
        type: f4
  connectivity_dependent_faces:
    seq:
      - id: num_connectivity_dependent_faces
        type: u4
      - id: connectivity_dependent_faces_stream_size
        type: u4
      - id: connectivity_dependent_faces_stream
        type: cdf_stream
        size: connectivity_dependent_faces_stream_size
  cdf_stream:
    seq:
      - id: connectivity_dependent_faces
        type: connectivity_dependent_face
        repeat: expr
        repeat-expr: _parent.num_connectivity_dependent_faces
  connectivity_dependent_face:
    seq:
      - id: size
        type: u4
      - id: data
        type: cdf_data
        size: size - 4
  cdf_data:
    seq:
      - id: is_knob
        type: b1
      - id: is_shell
        type: b1
      - id: is_detail
        type: b1
      - id: is_tube
        type: b1
      - id: padding
        size: 3
      - id: start_vertex
        type: u4
      - id: num_vertices
        type: u4
      - id: start_index
        type: u4
      - id: num_indices
        type: u4
      - id: ofs_optional
        type: u4
      - id: num_or_fields
        type: u4
      - id: or_fields
        type: or_field
        repeat: expr
        repeat-expr: num_or_fields
    instances:
      optional:
        pos: ofs_optional - 4
        type: optional
        if: ofs_optional != 0
  or_field:
    seq:
      - id: size
        type: u4
      - id: data
        type: or_field_data
        size: size - 4
  or_field_data:
    seq:
      - id: num_fields
        type: u4
      - id: fields
        type: field
        repeat: expr
        repeat-expr: num_fields
  field:
    seq:
      - id: size
        type: u4
      - id: data
        type: field_data
        size: size - 4
  field_data:
    seq:
      - id: index
        type: u4
      - id: num_args
        type: u4
      - id: args
        type: optimization_query_arg
        repeat: expr
        repeat-expr: num_args
  optimization_query_arg:
    seq:
      - id: feature_index
        type: u4
      - id: occlusion_shape_lookup
        type: u4
        repeat: expr
        repeat-expr: 3
  optional:
    seq:
      - id: num_vertices
        type: u4
      - id: num_indices
        type: u4
      - id: vertices
        type: common::vector3
        repeat: expr
        repeat-expr: num_vertices
      - id: normals
        type: common::vector3
        repeat: expr
        repeat-expr: num_vertices
        if: _root.has_normals
      - id: texture_coords
        type: common::vector2
        repeat: expr
        repeat-expr: num_vertices
        if: _root.has_texture_coords
      - id: indices
        type: u4
        repeat: expr
        repeat-expr: num_indices
      - id: packed_average_normal_indices
        type: u4
        repeat: expr
        repeat-expr: num_indices
      - id: packed_round_edge_indices
        type: u4
        repeat: expr
        repeat-expr: num_indices
