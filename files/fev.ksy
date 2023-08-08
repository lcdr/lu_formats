meta:
  id: fev64
  file-extension: fev
  endian: le
  imports:
    - ../common/common
seq:
  - id: file_type
    contents: "FEV1"
  - id: version
    contents: [0x00, 0x00, 0x40, 0x00]
  - id: unknown_checksum_1
    type: u4
    doc: Tied to sound definitions and waveforms
  - id: unknown_checksum_2
    type: u4
    doc: Tied to sound definitions and waveforms
  - id: manifest_entry_count
    type: u4
  - id: manifest_entries
    type: manifest_entry
    repeat: expr
    repeat-expr: manifest_entry_count
  - id: project_name
    type: common::u4_str
  - id: bank_count
    type: u4
  - id: banks
    type: bank
    repeat: expr
    repeat-expr: bank_count
  - id: event_categories
    type: event_category
  - id: root_event_group_count
    type: u4
  - id: event_groups
    type: event_group
    repeat: expr
    repeat-expr: root_event_group_count
  - id: sound_definition_config_count
    type: u4
  - id: sound_definition_configs
    type: sound_definition_config
    repeat: expr
    repeat-expr: sound_definition_config_count
  - id: sound_definition_count
    type: u4
  - id: sound_definitions
    type: sound_definition
    repeat: expr
    repeat-expr: sound_definition_count
  - id: reverb_definition_count
    type: u4
  - id: reverb_definitions
    type: reverb_definition
    repeat: expr
    repeat-expr: reverb_definition_count
  - id: music_data
    type: music_data
types:
  manifest_entry:
    seq:
      - id: type
        type: u4
        enum: manifest_type
      - id: value
        type: u4
    enums:
      manifest_type:
        0x00:
          id: unknown_0x00
          doc: Always 1?
        0x01: bank_count
        0x02: event_category_count
        0x03: event_group_count
        0x04: user_property_count
        0x05: event_parameter_count
        0x06: effect_envelope_count
        0x07: envelope_point_count
        0x08: sound_instance_count
        0x09:
          id: layer_count
          doc: Note this does not include the single layer of simple events
        0x0A: simple_event_count
        0x0B: complex_event_count
        0x0C: reverb_definition_count
        0x0D: waveform_wavetable_count
        0x0E: waveform_oscillator_count
        0x0F: waveform_dont_play_entry_count
        0x10: waveform_programmer_sound_count
        0x11: sound_definition_count
        0x12:
          id: unknown_0x12
          doc: Always 0?
        0x13: project_name_size
        0x14: bank_names_total_size
        0x15: event_category_names_total_size
        0x16: event_group_names_total_size
        0x17: user_property_names_total_size
        0x18: user_property_string_values_total_size
        0x19: event_parameter_names_total_size
        0x1A: effect_envelope_names_total_size
        0x1B: event_names_total_size
        0x1C:
          id: event_instance_category_names_total_size
          doc: Note that this is the serialized size, and the category names is serialized per event, so if multiple events contain a category, it is added multiple times, and if no events contain a category, the category does not contribute.
        0x1D: reverb_definition_names_total_size
        0x1E: wavetable_file_names_total_size
        0x1F: wavetable_bank_names_total_size
        0x20:
          id: sound_definition_names_total_size
          doc: Note that sound definition names are "paths" (a sound definition sd in folder f will have name /f/sd)
  bank:
    seq:
      # Decompress into memory --> 00 01 00 00
      # Load into memory       --> 00 02 00 00
      # Stream from disk       --> 80 00 00 00
      - id: unknown
        size: 4
      - id: max_streams
        type: s4
      - id: unknown_checksum
        size: 8
      - id: name
        type: common::u4_str
  event_category:
    seq:
      - id: name
        type: common::u4_str
      - id: volume
        type: f4
      - id: pitch
        type: f4
      - id: max_streams
        type: s4
      - id: max_playback_behavior
        type: u4
        enum: max_playback_behavior
      - id: subcategory_count
        type: u4
      - id: subcategories
        type: event_category
        repeat: expr
        repeat-expr: subcategory_count
    enums:
      max_playback_behavior:
        0: steal_oldest
        1: steal_newest
        2: steal_quietest
        3: just_fail
        4: just_fail_if_quietest
  event_group:
    seq:
      - id: name
        type: common::u4_str
      - id: user_property_count
        type: u4
      - id: user_properties
        type: user_property
        repeat: expr
        repeat-expr: user_property_count
      - id: subgroup_count
        type: u4
      - id: event_count
        type: u4
      - id: subgroups
        type: event_group
        repeat: expr
        repeat-expr: subgroup_count
      - id: events
        type: event
        repeat: expr
        repeat-expr: event_count
  user_property:
    seq:
      - id: name
        type: common::u4_str
      - id: type
        type: u4
        enum: user_property_type
      - id: value
        type:
          switch-on: type
          cases:
            'user_property_type::integer': u4
            'user_property_type::float': f4
            'user_property_type::string': common::u4_str
    enums:
      user_property_type:
        0: integer
        1: float
        2: string
  event:
    seq:
      # Maybe this is actually a bitfield? 
      - id: is_simple_event
        type: u4
        enum: is_simple_event
      - id: name
        type: common::u4_str
      - id: guid
        size: 16
      - id: volume
        type: f4
      - id: pitch
        type: f4
      - id: pitch_randomization
        type: f4
      - id: volume_randomization
        type: f4
      - id: priority
        type: u2
      - id: unknown2
        size: 2
      - id: max_playbacks
        type: u4
      - id: steal_priority
        type: u4
      - id: threed_flags
        type: event_3d_flags
      - id: threed_min_distance
        type: f4
      - id: threed_max_distance
        type: f4
      - id: event_flags
        type: event_flags
      - id: twod_speaker_l
        type: f4
      - id: twod_speaker_r
        type: f4
      - id: twod_speaker_c
        type: f4
      - id: speaker_lfe
        type: f4
      - id: twod_speaker_lr
        type: f4
      - id: twod_speaker_rr
        type: f4
      - id: twod_speaker_ls
        type: f4
      - id: twod_speaker_rs
        type: f4
      - id: threed_cone_inside_angle
        type: f4
      - id: threed_cone_outside_angle
        type: f4
      - id: threed_cone_outside_volume
        type: f4
      - id: max_playbacks_behavior
        type: u4
        enum: max_playback_behavior
      - id: threed_doppler_factor
        type: f4
      - id: reverb_dry_level
        type: f4
      - id: reverb_wet_level
        type: f4
      - id: threed_speaker_spread
        type: f4
      - id: fade_in_time
        type: u2
      # 0x0000 if fade_in_time < 32768, 0xFFFF otherwise
      - id: fade_in_time_flag
        type: u2
      - id: fade_out_time
        type: u2
      # 0x0000 if fade_in_time < 32768, 0xFFFF otherwise
      - id: fade_out_time_flag
        type: u2
      - id: spawn_intensity
        type: f4
      - id: spawn_intensity_randomization
        type: f4
      - id: threed_pan_level
        type: f4
      - id: threed_position_randomization
        type: u4
      - id: layer_count
        type: u4
        if: is_simple_event == is_simple_event::false
      - id: layers
        type: layer(false)
        repeat: expr
        repeat-expr: layer_count
        if: is_simple_event == is_simple_event::false
      - id: layer
        type: layer(true)
        if: is_simple_event == is_simple_event::true
      - id: parameter_count
        type: u4
        if: is_simple_event == is_simple_event::false
      - id: parameters
        type: event_parameter
        repeat: expr
        repeat-expr: parameter_count
        if: is_simple_event == is_simple_event::false
      - id: user_property_count
        type: u4
        if: is_simple_event == is_simple_event::false
      - id: user_properties
        type: user_property
        repeat: expr
        repeat-expr: user_property_count
        if: is_simple_event == is_simple_event::false
      - id: unknown9
        size: 4
      - id: category
        type: common::u4_str
    enums:
      max_playback_behavior:
        1: steal_oldest
        2: steal_newest
        3: steal_quietest
        4: just_fail
        5: just_fail_if_quietest
  event_flags:
    seq:
      - id: unknown1
        size: 2
      - id: unknown2
        type: b4
      - id: oneshot
        type: b1
      - id: unknown3
        type: b3
      - id: unknown4
        size: 1
  event_3d_flags:
    seq:
      - id: unknown1
        type: b3
      - id: mode_2d
        type: b1
      - id: mode_3d
        type: b1
      - id: unknown2
        type: b3
      - id: unknown3
        size: 1
      - id: unknown4
        type: b2
      - id: threed_rolloff_lienar
        type: b1
      - id: threed_rolloff_logarithmic
        type: b1
      - id: threed_position_world_relative
        type: b1
      - id: threed_position_head_relative
        type: b1
      - id: unknown5
        type: b2
      - id: ignore_geometry
        type: b1
      - id: unknown6
        type: b7
  layer:
    params:
      - id: is_simple_event
        type: b1
    seq:
      - id: unknown
        size: 2
        if: is_simple_event == false
      - id: priority
        type: s2
        doc: -1 --> use event priority
        if: is_simple_event == false
      - id: control_parameter_index
        type: s2
        doc: -1 --> unset (eg when no parameters are defined)
        if: is_simple_event == false
      - id: sound_instance_count
        type: u2
      - id: effect_envelope_count
        type: u2
      - id: sound_instances
        type: sound_instance
        repeat: expr
        repeat-expr: sound_instance_count
      - id: effect_envelopes
        type: effect_envelope
        repeat: expr
        repeat-expr: effect_envelope_count
  sound_instance:
    seq:
      - id: sound_definition_index
        type: u2
      - id: start_position
        type: f4
      - id: length
        type: f4
      - id: start_mode
        type: u4
        enum: start_mode
      - id: loop_mode
        type: u2
        enum: loop_mode
      - id: autopitch_parameter
        type: u2
        enum: autopitch_parameter
      - id: loop_count
        type: s4
        doc: -1 --> disabled
      - id: autopitch_enabled
        type: u4
        enum: autopitch_enabled
      - id: autopitch_reference
        type: f4
      - id: autopitch_at_min
        type: f4
      - id: fine_tune
        type: f4
      - id: unknown2
        size: 12
      - id: fade_in_type
        type: u4
      - id: fade_out_type
        type: u4
    enums:
      start_mode:
        0: immediate
        1: wait_for_previous
      loop_mode:
        0: loop_and_cutoff
        1: oneshot
        2: loop_and_play_to_end
      autopitch_enabled:
        1: yes
        2: no
      autopitch_parameter:
        0: event_primary_parameter
        2: layer_control_parameter
  effect_envelope:
    seq:
      - id: unknown
        size: 4
      - id: name
        type: common::u4_str
      - id: unknown2a
        size: 4
      - id: unknown2b
        size: 4
      - id: unknown2c
        size: 4
      - id: envelope_point_count
        type: u4
      - id: envelope_points
        type: effect_envelope_point
        repeat: expr
        repeat-expr: envelope_point_count
      - id: unknown3
        size: 8
  effect_envelope_point:
    seq:
      - id: position
        type: u4
      - id: value
        type: f4
      - id: curve_shape
        type: u4
        enum: curve_shape
    enums:
      curve_shape:
        1: flat_ended
        2: linear
        4: log
        8: flat_middle
  event_parameter:
    seq:
      - id: name
        type: common::u4_str
      - id: velocity
        type: f4
      - id: minimum_value
        type: f4
      - id: maximum_value
        type: f4
      - id: bitmask
        type: event_parameter_flags
      - id: seek_speed
        type: f4
      - id: unknown
        size: 8
        doc: Padding? Always 0
  event_parameter_flags:
    doc: loop, oneshot_and_stop_event, and oneshot are exclusive. keyoff_on_silence only works with oneshot
    seq:
      - id: keyoff_on_silence
        type: b1
      - id: unknown1
        type: b3
      - id: loop
        type: b1
      - id: oneshot_and_stop_event
        type: b1
      - id: oneshot
        type: b1
      - id: primary
        type: b1
      - id: unknown2
        size: 3
  sound_definition_config:
    seq:
      - id: play_mode
        type: u4
        enum: play_mode
      - id: spawn_time_min
        type: u4
      - id: spawn_time_max
        type: u4
      - id: maximum_spawned_sounds
        type: u4
      - id: volume
        type: f4
      - id: unknown1
        type: u4
      - id: unknown2
        type: f4
      - id: unknown3
        type: f4
      - id: volume_randomization
        type: f4
      - id: pitch
        type: f4
      - id: unknown4
        size: 12
      - id: pitch_randomization
        type: f4
      - id: pitch_randomization_behavior
        type: u4
        enum: pitch_randomization_behavior
      - id: threed_position_randomization
        type: f4
      - id: trigger_delay_min
        type: u2
      - id: trigger_delay_max
        type: u2
      - id: spawn_count
        type: u2
    enums:
      play_mode:
        0: sequential
        1: random
        2: random_no_repeat
        3: sequential_event_restart
        4: shuffle
        5: programmer_selected
        6: shuffle_global
        7: sequential_global
      pitch_randomization_behavior:
        0: randomize_every_spawn
        1: randomize_when_triggered_by_parameter
        2: randomize_when_event_starts
  sound_definition:
    seq:
      - id: name
        type: common::u4_str
      - id: config_index
        type: u4
      - id: waveform_count
        type: u4
      - id: waveforms
        type: waveform
        repeat: expr
        repeat-expr: waveform_count
  waveform:
    seq:
      - id: type
        type: u4
        enum: waveform_type
      - id: weight
        type: u4
      - id: parameters
        type:
          switch-on: type
          cases:
            'waveform_type::wavetable': wavetable_params
            'waveform_type::dont_play': dont_play_params
            'waveform_type::oscillator': oscillator_params
            'waveform_type::programmer': programmer_params
    enums:
      waveform_type:
        0: wavetable
        1: oscillator
        2: dont_play
        3: programmer
  oscillator_params:
    seq:
      - id: type
        type: u4
        enum: oscillator_type
      - id: frequency
        type: f4
    enums:
      oscillator_type:
        0: sine
        1: square
        2: saw_up
        3: saw_down
        4: triangle
        5: noise
  dont_play_params: {}
  programmer_params: {}
  wavetable_params:
    seq:
      - id: filename
        type: common::u4_str
      - id: bank_name
        type: common::u4_str
      - id: unknown
        size: 4
      - id: length
        type: u4
        doc: In milliseconds
  reverb_definition:
    seq:
      - id: name
        type: common::u4_str
      - id: master_level
        type: s4
        doc: 0 to -100, serialized as 0 to -10000 (ie, out to two decimal places then multiply by 100)
      - id: hf_gain
        type: s4
        doc: 0 to -100, serialized as 0 to -10000 (ie, out to two decimal places then multiply by 100)
      - id: unknown1
        size: 4
      - id: decay_time
        type: f4
        doc: in seconds
      - id: hf_decay_ratio
        type: f4
      - id: early_reflections
        type: s4
        doc: 10 to -100, serialized as 1000 to -10000 (ie, out to two decimal places then multiply by 100)
      - id: pre_delay
        type: f4
        doc: in seconds
      - id: late_reflections
        type: s4
        doc: 20 to -100, serialized as 2000 to -10000 (ie, out to two decimal places then multiply by 100)
      - id: late_delay
        type: f4
        doc: in seconds
      - id: diffusion
        type: f4
      - id: density
        type: f4
      - id: hf_crossover
        type: f4
        doc: in hz
      - id: lf_gain_a
        type: f4
        doc: 0 to -100, serialized as 0 to -10000 (ie, out to two decimal places then multiply by 100)
      - id: lf_crossover_a
        type: f4
        doc: in hz
      - id: unknown3
        size: 16
      - id: lf_gain_b
        type: s4
        doc: 0 to -100, serialized as 0 to -10000 (ie, out to two decimal places then multiply by 100)
      - id: unknown4
        size: 48
      - id: lf_crossover_b
        type: f4
        doc: in hz
      - id: unknownzzzz
        size: 4
  music_data:
    seq:
      - id: items
        type: music_data_item
        repeat: eos
  music_data_item:
    seq:
      - id: len
        type: u4
      - id: data
        size: len - 4
        type: music_data_data
  music_data_data:
    seq:
      - id: chunks
        type: music_data_chunk
        repeat: eos
  music_data_chunk:
    seq:
      - id: type
        type: str
        size: 4
        encoding: ascii
      - id: data
        type:
          switch-on: type
          cases:
            '"comp"': music_data
            # Settings
            '"sett"': md_chunk_sett
            # Themes
            '"thms"': music_data
            '"thmh"': u2
            '"thm "': music_data
            '"thmd"': md_chunk_thmd
            # Cues
            '"cues"': music_data
            '"entl"': md_chunk_entl
            # Sounds
            '"scns"': music_data
            '"scnh"': u2
            '"scnd"': md_chunk_scnd
            # Parameters
            '"prms"': music_data
            '"prmh"': u2
            '"prmd"': u4
            # Segments
            '"sgms"': music_data
            '"sgmh"': u2
            '"sgmd"': md_chunk_sgmd
            # Samples
            '"smps"': music_data
            '"smph"': md_chunk_smph
            '"smpf"': music_data
            '"str "': md_chunk_str
            '"smpm"': u4
            '"smp "': md_chunk_smp
            # Links
            '"lnks"': music_data
            '"lnkh"': u2
            '"lnkd"': md_chunk_lnkd
            '"lfsh"': u2
            '"lfsd"': md_chunk_lfsd
            # Timelines
            '"tlns"': music_data
            '"tlnh"': u2
            '"tlnd"': md_chunk_tlnd
            # Conditions
            '"cond"': md_chunk_cond
            '"cms "': md_chunk_cms
            '"cprm"': md_chunk_cprm
  # Global volume and reverb
  md_chunk_sett:
    seq:
      - id: volume
        type: f4
      - id: reverb
        type: f4
  md_chunk_thmd:
    seq:
      - id: theme_id
        type: u4
      - id: playback_method
        type: u1
        enum: playback_method
      - id: default_transition
        type: u1
        enum: default_transition
        doc: only used with playback_method sequenced
      - id: quantization
        type: u1
        enum: quantization
        doc: Used only with playback method concurrent or default transition crossfade
      - id: transition_timeout
        type: u4
        doc: Used only with default transition queued
      - id: crossfade_duration
        type: u4
        doc: Used only with default transition crossfade
      - id: end_count
        type: u2
      - id: end_sequence_ids
        type: u4
        repeat: expr
        repeat-expr: end_count
      - id: start_count
        type: u2
      - id: start_sequence_ids
        type: u4
        repeat: expr
        repeat-expr: start_count
    enums:
      playback_method:
        0: sequenced
        1: concurrent
      default_transition:
        0: never
        1: queued
        2: crossfade
      quantization:
        0: free
        1: on_bar
        2: on_beat
  md_chunk_entl:
    seq:
      - id: count
        type: u2
      - id: names_length
        type: u2
      - id: ids
        type: u4
        repeat: expr
        repeat-expr: count
      # It's unclear how this connects to the fact that names_length was specified,
      # maybe a way to skip over quickly? Regardless this appears to be accurate
      - id: cue_names
        repeat: expr
        repeat-expr: count
        type: str
        terminator: 0
        encoding: ascii
  md_chunk_scnd:
    seq:
      - id: unknown1
        size: 4
      - id: count
        type: u2
      - id: cue_instances
        type: cue_instance
        repeat: expr
        repeat-expr: count
  cue_instance:
    seq:
      - id: cue_id
        type: u4
      - id: unknown
        type: u4
  md_chunk_sgmd:
    seq:
      - id: segment_id
        type: u4
      - id: unknown
        size: 4
      - id: timeline_id
        type: u4
      - id: time_signature_beats
        type: u1
      - id: time_signature_beat_value
        type: u1
      - id: beats_per_minute
        type: f4
      - id: unknown2
        size: 4
      - id: sync_beat_1
        type: b2
      - id: sync_beat_2
        type: b2
      - id: sync_beat_3
        type: b2
      - id: sync_beat_4
        type: b2
      - id: sync_beat_5
        type: b2
      - id: sync_beat_6
        type: b2
      - id: sync_beat_7
        type: b2
      - id: sync_beat_8
        type: b2
      - id: sync_beat_9
        type: b2
      - id: sync_beat_10
        type: b2
      - id: sync_beat_11
        type: b2
      - id: sync_beat_12
        type: b2
      - id: sync_beat_13
        type: b2
      - id: sync_beat_14
        type: b2
      - id: sync_beat_15
        type: b2
      - id: sync_beat_16
        type: b2
      - id: data
        type: music_data
  md_chunk_smph:
    seq:
      - id: playback_mode
        type: u1
        enum: playback_mode
      - id: count
        type: u4
    enums:
      playback_mode:
        0: sequential
        1: random
        2: random_without_repeat
        3: shuffled
  md_chunk_str:
    seq:
      - id: count
        type: u4
      - id: unknown
        size: 4
      - id: name_end_offsets
        type: u4
        repeat: expr
        repeat-expr: count
      # Technically the lengths are determined by the above, but this is more
      # convinient to record in kaitai for now (and they seem to end in null bytes anyways)
      - id: names
        repeat: expr
        repeat-expr: count
        type: str
        terminator: 0
        encoding: ascii
      - id: end_marker
        if: count == 0
        size: 1
        contents: [0x00]
  md_chunk_lnkd:
    seq:
      - id: segment_1_id
        type: u4
      - id: segment_2_id
        type: u4
      - id: transition_behavior
        type: transition_behavior
    types:
      transition_behavior:
        seq:
          - id: padding
            type: b1
          - id: at_segment_end
            type: b1
          - id: on_bar
            type: b1
          - id: on_beat
            type: b1
          - id: padding2
            size: 3
  md_chunk_lfsd:
    seq:
      - id: unknown
        size: 4
      - id: count
        type: u2
      - id: thing
        size: 4
        repeat: expr
        repeat-expr: count
  md_chunk_smp:
    seq:
      - id: bank_name
        type: common::u4_str
      - id: index
        type: u4
  md_chunk_tlnd:
    seq:
      - id: timeline_id
        size: 4
  md_chunk_cond:
    seq:
      - id: nop
        size: 0
  md_chunk_cms:
    seq:
      - id: condition_type
        type: u1
        enum: condition_type
      - id: theme_id
        type: u4
      - id: cue_id
        type: u4
    enums:
      condition_type:
        0: on_theme
        1: on_cue
  md_chunk_cprm:
    seq:
      - id: condition_type
        type: u2
        enum: condition_type
      - id: param_id
        type: u4
      - id: value_1
        type: u4
      - id: value_2
        doc: If comparrison type only requires one operand, these 4 bytes are padding
        type: u4
    enums:
      condition_type:
        0: equal_to
        1: greater_than
        2: greater_than_including
        3: less_than
        4: less_than_including
        5: between
        6: between_including
enums:
  is_simple_event:
    8: 'false'
    16: 'true'
