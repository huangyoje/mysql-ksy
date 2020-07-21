

types:
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
      - id: number_of_fields
        doc: number of fields in this record, 1 to 1023
        type: b10
      - id: 1byte_offs_flag
        doc: 1 if each Field Start Offsets is 1 byte long (this item is also called the "short" flag)
        type: b1
      - id: relative_offset_of_next_record
        type: u2
