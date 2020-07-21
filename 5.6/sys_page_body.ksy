meta:
  id: sys_page_body
  endian: be
  imports:
    - fseg_entry
    - list_base_node

seq:
  - id: rollback_segment_header
    type: rollback_segment_header
  - id: undo_segment_slots
    type: undo_segment_slot
    repeat: expr
    repeat-expr: 1024
  - id: empty_space
    size: 12208

types:
  rollback_segment_header:
    seq:
      - id: max_size
        type: u4
      - id: history_size
        type: u4
      - id: history_list_base_node
        type: list_base_node
      - id: fseg_entry
        type: fseg_entry

  undo_segment_slot:
    seq:
      - id: unknown
        size: 4
