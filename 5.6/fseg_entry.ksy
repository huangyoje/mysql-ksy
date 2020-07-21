meta:
  id: fseg_entry
  endian: be

# size: 10
seq:
  - id: space_id
    type: u4
  - id: page
    doc: page number within a space
    type: u4
  - id: offset
    doc: byte offset within the page
    type: u2
