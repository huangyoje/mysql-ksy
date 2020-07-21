meta:
  id: table_space
  endian: be
  imports:
    - page

seq:
  - id: pages1
    type: page
    repeat: until
    repeat-until: _.header.page_number == 5
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
