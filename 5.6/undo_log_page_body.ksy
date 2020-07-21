meta:
  id: undo_log_page_body
  endian: be
  imports:
    - list_base_node
    - list_node
    - fseg_entry

seq:
  - id: undo_page_header
    type: undo_page_header
  - id: undo_segment_header
    type: undo_segment_header
  - id: undo_records
    size: 16290

types:
  undo_page_header:
    seq:
      - id: undo_page_type
        size: 2
      - id: latest_log_record_offset
        size: 2
      - id: free_space_offset
        size: 2
      - id: undo_page_list_node
        type: list_node

  undo_segment_header:
    seq:
      - id: state
        size: 2
      - id: latest_log_offset
        size: 2
      - id: undo_segment_fseg_entry
        type: fseg_entry
      - id: undo_segment_page_list_base_node
        type: list_base_node
