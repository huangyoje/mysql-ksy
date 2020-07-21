meta:
  id: inode_page_body
  endian: be
  imports:
    - list_base_node
    - list_node

seq:
  - id: inode_page_list
    type: list_node
  - id: inode_entries
    type: inode_entry
    repeat: expr
    repeat-expr: 85
  - id: empty_spaces
    size: 6

types:
  inode_entry:
    seq:
      - id: fseg_id
        type: u8
      - id: number_of_used_pages_in_not_full_list
        type: u4
      - id: list_base_node_for_free_list
        type: list_base_node
      - id: list_base_node_for_not_full_list
        type: list_base_node
      - id: list_base_node_for_full_list
        type: list_base_node
      - id: magic_number
        type: u4
      - id: fseg_frag_arr
        type: u4
        repeat: expr
        repeat-expr: 32
