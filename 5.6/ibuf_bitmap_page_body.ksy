meta:
  id: ibuf_bitmap_page_body
  endian: be

seq:
  - id: change_buffer_bitmap
    type: ibuf_bitmap_entry
    repeat: expr
    repeat-expr: 16384
  - id: empty_spaces
    size: 8146

types:
  ibuf_bitmap_entry:
    seq:
      - id: free_space
        type: b2
      - id: buffered_flag
        type: b1
      - id: change_buffer_flag
        type: b1
