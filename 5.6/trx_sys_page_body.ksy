meta:
  id: trx_sys_page_body
  endian: be
  imports:
    - fseg_entry

seq:
  - id: transaction_id
    type: u8
  - id: trx_sys_fseg_entry
    size: 10
  - id: rollback_segments
    type: rollback_segment
    repeat: expr
    repeat-expr: 128
  - id: empty_space0
    size: 13304
  - id: master_log_info
    type: log_info
  - id: empty_space1
    size: 888
  - id: binary_log_info
    type: log_info
  - id: empty_space2
    size: 688
  - id: doublewrite_buffer_info
    type: doublewrite_buffer_info
  - id: empty_space3
    size: 154

types:
  rollback_segment:
    seq:
      - id: space
        size: 4
      - id: page
        size: 4

  log_info:
    seq:
      - id: magic_number
        size: 4
      - id: log_offset
        size: 8
      - id: log_name
        size: 100
        type: str
        encoding: ASCII

  doublewrite_buffer_info:
    seq:
      - id: fseg_entry
        type: fseg_entry
      - id: magic_number1
        size: 4
      - id: block1_start_page1
        type: u4
      - id: block2_start_page1
        type: u4
      - id: magic_number2
        size: 4
      - id: block1_start_page2
        type: u4
      - id: block2_start_page2
        type: u4
      - id: space_id
        type: u4
