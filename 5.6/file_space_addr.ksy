meta:
  id: file_space_addr
  endian: be

seq:
  - id: page
    doc: page number within a space
    type: u4
  - id: offset
    doc: byte offset within the page
    type: u2
