meta:
  id: list_base_node
  endian: be
  imports:
    - file_space_addr

seq:
  - id: list_length
    type: u4
  - id: first_node
    type: file_space_addr
  - id: last_node
    type: file_space_addr
