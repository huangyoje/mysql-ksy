meta:
  id: list_node
  endian: be
  imports:
    - file_space_addr

# size: 12
seq:
  - id: previous_node
    type: file_space_addr
  - id: next_node
    type: file_space_addr
