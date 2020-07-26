meta:
  id: inode_page_body
  endian: be
  imports:
    - list_base_node
    - list_node

doc-ref: storage/innobase/include/fsp0fsp.h

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
        doc: |
          Extents that are completely unused and are allocated to this file segment.
      - id: list_base_node_for_not_full_list
        type: list_base_node
        doc: |
          Extents with at least one used page allocated to this file segment. When
          the last free page is used, the extent is moved to the FULL list.
      - id: list_base_node_for_full_list
        type: list_base_node
        doc: |
          Extents with no free pages allocated to this file segment. If a page becomes
          free, the extent is moved to the NOT_FULL list.
      - id: magic_number
        type: u4
        doc: The value 97937874 is stored as a marker that this file segment INODE entry has been properly initialized.
      - id: fseg_frag_arr
        type: u4
        repeat: expr
        repeat-expr: 32
