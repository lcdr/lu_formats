meta:
  id: pk
  file-extension: pk
  endian: le
  imports:
    - ../common/common
seq:
  - id: header
    contents: ["ndpk", 0x01, 0xff, 0x00]
instances:
  ofs_toc:
    pos: _io.size - 8
    type: u4
  file_revision:
    pos: _io.size - 4
    type: u4
  toc:
    pos: ofs_toc
    type: toc
types:
  toc:
    seq:
      - id: num_files
        type: u4
      - id: file_indices
        type: pack_index
        repeat: expr
        repeat-expr: num_files
  pack_index:
    seq:
      - id: crc
        type: u4
      - id: lower_crc
        type: s4
      - id: upper_crc
        type: s4
      - id: uncompressed_size
        type: u4
      - id: uncompressed_checksum
        type: strz
        size: 36
        encoding: ascii
      - id: compressed_size
        type: u4
      - id: compressed_checksum
        type: strz
        size: 36
        encoding: ascii
      - id: ofs_data
        type: u4
      - id: is_compressed
        type: common::bool
        size: 4
    instances:
      data:
        pos: ofs_data
        size: "is_compressed.bool == common::boolean::true ? compressed_size : uncompressed_size"
      data_divider:
        pos: "ofs_data + (is_compressed.bool == common::boolean::true ? compressed_size : uncompressed_size)"
        contents: [0xff, 0x00, 0x00, 0xdd, 0x00]
