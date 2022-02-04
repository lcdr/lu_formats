meta:
  id: fdb
  file-extension: fdb
  endian: le
  imports:
    - ../common/common
seq:
  - id: num_tables
    type: u4
  - id: ofs_table
    type: u4
instances:
  tables:
    pos: ofs_table
    type: table
    repeat: expr
    repeat-expr: num_tables
types:
  table:
    seq:
      - id: ofs_table_desc
        type: u4
      - id: ofs_hash_table
        type: u4
    instances:
      table_desc:
        pos: ofs_table_desc
        type: table_description
      hash_table:
        pos: ofs_hash_table
        type: hash_table
  table_description:
    seq:
      - id: num_columns
        type: u4
      - id: table_name
        type: text
      - id: ofs_columns
        type: u4
    instances:
      columns:
        pos: ofs_columns
        type: column_description
        repeat: expr
        repeat-expr: num_columns
  column_description:
    seq:
      - id: data_type
        type: u4
        enum: variant_type
      - id: column_name
        type: text
  hash_table:
    seq:
      - id: table_size
        type: u4
      - id: ofs_buckets
        type: u4
    instances:
      buckets:
        pos: ofs_buckets
        type: hash_bucket
        repeat: expr
        repeat-expr: table_size
  hash_bucket:
    seq:
      - id: ofs_data
        type: u4
    instances:
      data:
        pos: ofs_data
        type: list_rows
        if: ofs_data != 0xffffffff
  list_rows:
    seq:
      - id: ofs_row_data
        type: u4
      - id: ofs_next_data
        type: u4
    instances:
      row_data:
        pos: ofs_row_data
        type: row_data
      next_data:
        pos: ofs_next_data
        type: list_rows
        if: ofs_next_data != 0xffffffff
  row_data:
    seq:
      - id: num_data
        type: u4
      - id: ofs_data_array
        type: u4
    instances:
      data_array:
        pos: ofs_data_array
        type: variant_data
        repeat: expr
        repeat-expr: num_data
  variant_data:
    seq:
      - id: data_type
        type: u4
        enum: variant_type
      - id: data
        type:
          switch-on: data_type
          cases:
            variant_type::null: null_data
            variant_type::i32: s4
            variant_type::u32: u4
            variant_type::real: f4
            variant_type::nvarchar: text
            variant_type::bool: common::bool
            variant_type::i64: i64
            variant_type::u64: u64
            variant_type::text: text
  null_data:
    seq:
      - id: null_data
        contents: [0x00, 0x00, 0x00, 0x00]
  i64:
    seq:
      - id: ofs_i64
        type: u4
    instances:
      i64:
        pos: ofs_i64
        type: s8
  u64:
    seq:
      - id: ofs_u64
        type: u4
    instances:
      u64:
        pos: ofs_u64
        type: u8
  text:
    seq:
      - id: ofs_text
        type: u4
    instances:
      text:
        pos: ofs_text
        type: strz
        encoding: ascii
enums:
  variant_type:
    0: "null"
    1: i32
    2: u32
    3: real
    4: nvarchar
    5: bool
    6: i64
    7: u64
    8: text