meta:
  id: sd0
  file-extension: sd0
  endian: le
  imports:
    - ../common/common
seq:
  - id: header
    contents: ['sd0', 0x01, 0xFF]
  - id: compressed_chunks
    type: compressed_chunks
    repeat: eos
types:
  compressed_chunks:
    seq:
      - id: chunk_size
        type: u4
      - id: compressed_chunk
        size: chunk_size
