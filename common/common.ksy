meta:
  id: common
  endian: le
  bit-endian: le
types:
  vector2:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
  vector3:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
  object_id:
    seq:
      - id: object_id
        type: u8
  lot:
    seq:
      - id: lot
        type: s4
  quaternion:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
      - id: w
        type: f4
  quaternion_wxyz:
    seq:
      - id: w
        type: f4
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
  u1_str:
    seq:
      - id: length
        type: u1
      - id: str
        type: str
        size: length
        encoding: ascii
  u1_wstr:
    seq:
      - id: length
        type: u1
      - id: str
        type: str
        size: length * 2
        encoding: utf-16le
  u4_str:
    seq:
      - id: length
        type: u4
      - id: str
        type: str
        size: length
        encoding: ascii
  u4_wstr:
    seq:
      - id: length
        type: u4
      - id: str
        type: str
        size: length * 2
        encoding: utf-16le
  bool:
    seq:
      - id: bool
        type: u1
        enum: boolean
enums:
  boolean:
    0: false
    1: true
