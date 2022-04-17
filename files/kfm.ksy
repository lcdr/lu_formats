meta:
  id: kfm
  file-extension: kfm
  endian: le
  imports:
    - ../common/common
seq:
  - id: version
    type: u1
  - id: magic
    contents: "Gamebryo KFM File Version 2.2.0.0b\n"
  - id: is_little_endian
    contents: [0x01]
  - id: model_path
    type: common::u4_str
  - id: model_root
    type: common::u4_str
  - id: default_sync_transition_type
    type: u4
  - id: default_non_sync_transition_type
    type: u4
  - id: default_sync_transition_duration
    type: f4
  - id: default_non_sync_transition_duration
    type: f4
  - id: num_sequences
    type: u4
  - id: sequences
    type: sequence
    repeat: expr
    repeat-expr: num_sequences
  - id: num_sequence_groups
    type: u4
  - id: sequence_groups
    type: sequence_group
    repeat: expr
    repeat-expr: num_sequence_groups
types:
  sequence:
    seq:
      - id: id
        type: u4
      - id: kf_filename
        type: common::u4_str
      - id: anim_index
        type: u4
      - id: num_transitions
        type: u4
      - id: transitions
        type: transition
        repeat: expr
        repeat-expr: num_transitions
  transition:
    seq:
      - id: des_id
        type: u4
      - id: stored_type
        type: u4
        enum: transition_type
      - id: ext
        type: transition_ext
        if: stored_type != transition_type::default_sync and stored_type != transition_type::default_non_sync
  transition_ext:
    seq:
      - id: duration
        type: f4
      - id: num_blend_pairs
        type: u4
      - id: blend_pairs
        type: blend_pair
        repeat: expr
        repeat-expr: num_blend_pairs
      - id: num_chain_sequences
        type: u4
      - id: chain_sequences
        type: chain_sequence
        repeat: expr
        repeat-expr: num_chain_sequences
  blend_pair:
    seq:
      - id: start_key
        type: common::u4_str
      - id: target_key
        type: common::u4_str
  chain_sequence:
    seq:
      - id: sequence_id
        type: u4
      - id: duration
        type: f4
  sequence_group:
    seq:
      - id: group_id
        type: u4
      - id: name
        type: common::u4_str
      - id: num_sequence_infos
        type: u4
      - id: sequence_infos
        type: sequence_info
        repeat: expr
        repeat-expr: num_sequence_infos
  sequence_info:
    seq:
      - id: sequence_id
        type: u4
      - id: priority
        type: s4
      - id: weight
        type: f4
      - id: ease_in_time
        type: f4
      - id: ease_out_time
        type: f4
      - id: sync_sequence_id
        type: u4
enums:
  transition_type:
    0: blend
    1: morph
    2: crossfade
    3: chain
    4: default_sync
    5: default_non_sync
