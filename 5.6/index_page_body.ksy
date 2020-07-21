meta:
  id: index_page_body
  endian: be
  imports:
    - fseg_entry

doc-ref: storage/innobase/include/page0page.h

seq:
  - id: index_header
    type: index_header
  - id: fseg_header
    type: fseg_header
  - id: system_records
    type: system_records
  - id: user_records
    size: 16256 - index_header.number_of_directory_slots * 2
  - id: page_directory
    type: u2
    repeat: expr
    repeat-expr: index_header.number_of_directory_slots

types:
  index_header:
    seq:
      - id: number_of_directory_slots
        type: u2
      - id: heap_top_pos
        doc: |
          The byte offset of the “end” of the currently used page.
          All space between the heap top and the end of the page directory is free space.
        type: u2
      - id: format
        type: b1
        enum: record_format
        doc: |
          The COMPACT record format is new in the Barracuda table format, while the
          REDUNDANT record format is the original one in the Antelope table format
          (neither of which had a name officially until Barracuda was created).

          The COMPACT format mostly eliminated information that was redundantly stored
          in each record and can be obtained from the data dictionary, such as the number
          of fields, which fields are nullable, and which fields are dynamic length.
      - id: number_of_heap_records
        doc: |
           The total number of records in the page, including the infimum and supremum
           system records, and garbage (deleted) records.
        type: b15
      - id: first_garbage_record_offset
        type: u2
      - id: garbage_space
        doc: number of bytes in deleted records
        type: u2
      - id: last_insert_pos
        doc: pointer to the last inserted record, or NULL if this info has been reset by a delete
        type: u2
      - id: page_direction
        doc:  |
          Three values are currently used for page direction: LEFT, RIGHT, and NO_DIRECTION.
          This is an indication as to whether this page is experiencing sequential inserts (
          to the left [lower values] or right [higher values]) or random inserts. At each
          insert, the record at the last insert position is read and its key is compared to
          the currently inserted record’s key, in order to determine insert direction.
        type: u2
        enum: page_direction
      - id: number_of_inserts_in_page_direction
        doc: |
          Once the page direction is set, any following inserts that don’t reset the direction
          (due to their direction differing) will instead increment this value.
        type: u2
      - id: number_of_records
        doc: The number of non-deleted user records in the page
        type: u2
      - id: max_transaction_id
        doc: |
          The maximum transaction ID of any modification to any record in this page.
        type: u8
      - id: page_level
        doc: |
          The level of this page in the index. Leaf pages are at level 0, and the level
          increments up the B+tree from there. In a typical 3-level B+tree, the root will
          be level 2, some number of internal non-leaf pages will be level 1, and leaf
          pages will be level 0.

          level of the node in an index tree; the leaf level is the level 0.
        type: u2
      - id: index_id
        doc: The ID of the index this page belongs to.
        type: u8

  fseg_header:
    doc-ref: storage/innobase/include/fsp0types.h
    seq:
      - id: leaf_pages_inode
        type: fseg_entry
      - id: internal_inode
        type: fseg_entry

  system_records:
    seq:
      - id: infimum_record
        type: infimum_record
      - id: supremum_record
        type: supremum_record

  infimum_record:
    seq:
      - id: header
        type: record_header
      - id: data
        size: 8
        type: str
        encoding: ASCII

  supremum_record:
    seq:
      - id: header
        type: record_header
      - id: data
        size: 8
        type: str
        encoding: ASCII

  record_header:
    seq:
      - id: unused_flags
        type: b2
      - id: deleted_flag
        type: b1
      - id: min_rec_flag
        type: b1
        doc: |
          this bit is set if and only if the record is the first user record on
          a non-leaf B-tree page that is the leftmost page on its level
      - id: number_of_records_owned
        type: b4
        doc: number of records owned by this record
      - id: heap_no
        doc: |
          The order in which this record was inserted into the heap. Heap records
          (which include infimum and supremum) are numbered from 0. Infimum is always
          order 0, supremum is always order 1. User records inserted will be numbered
          from 2.
        type: b13
      - id: record_type
        type: b3
        enum: record_type
      - id: relative_offset_of_next_record
        type: u2

enums:
  record_type:
    0: ordinary
    1: node_ptr
    2: infimum
    3: supremum
  record_format:
    0: redundant
    1: compact
  page_direction:
    1: page_left
    2: page_right
    5: page_no_direction
