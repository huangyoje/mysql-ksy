meta:
  id: table_space
  endian: be
  imports:
    - page

seq:
  - id: file_space_header
    type: page
  - id: ibuf_bitmap
    type: page
  - id: first_index_node
    type: page
  - id: ibuf_header
    type: page
  - id: ibuf_tree_root
    type: page
  - id: transaction_system_header
    type: page
  - id: first_rollback_segment
    type: page
  - id: data_dict_header
    type: page
  - id: placeholder
    type: u1
    if: save_pos1 == 0

instances:
  save_pos1:
    value: _io.pos
  pages2:
    pos: save_pos1
    type: page
    repeat: eos
