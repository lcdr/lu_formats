meta:
  id: pki
  file-extension: pki
  endian: le
  imports:
    - ../common/common
seq:
  - id: version
    contents: [0x03, 0x00, 0x00, 0x00]
  - id: num_file_names
    type: u4
  - id: file_names
    type: common::u4_str
    repeat: expr
    repeat-expr: num_file_names
  - id: num_pack_files
    type: u4
  - id: pack_files
    type: master_pack_index
    repeat: expr
    repeat-expr: num_pack_files
types:
  master_pack_index:
    seq:
      - id: crc
        type: u4
      - id: lower_crc
        type: s4
      - id: upper_crc
        type: s4
      - id: pack_files_index
        type: u4
      - id: is_compressed
        type: common::bool
        size: 4
