meta:
  id: fsp_hdr_page_body
  endian: be

seq:
  - id: fsp_header
    type: fsp_header
  - id: xdes_entries
    type: xdes_entry
    repeat: expr
    repeat-expr: 256
  - id: empty_spaces
    size: 5986

types:
  fsp_header:
    doc-ref: storage/innobase/include/fsp0fsp.h
    seq:
      - id: space_id
        type: u4
      - id: unused
        size: 4
      - id: size
        doc: Current size of the space in pages
        type: u4
      - id: free_limit
        doc: |
          Minimum page number for which the free list has not been initialized: the pages >= this limit are,
          by definition, free; note that in a single-table tablespace where size < 64 pages, this number is
          64, i.e., we have initialized the space about the first extent, but have not physically allocted
          those pages to the file
        type: u4
      - id: flags
        doc: fsp_space_t.flags, similar to dict_table_t::flags
        size: 4
      - id: number_of_pages_used_in_free_frag
        doc: number of used pages in the FSP_FREE_FRAG list. alas frag_n_used
        type: u4
      - id: free
        doc: |
          list of free extents.
          An Extent from this list could be allocated to a File Segment or could
          be allocated to FREE FRAG LIST.
        type: list_base_node
      - id: free_frag
        doc: |
          List of partially free extents not belonging to any segment.
          This list contains the Extents which have at least one free page to be allocated.
        type: list_base_node
      - id: full_frag
        doc: |
          List of full extents not belonging to any segment.
          This list contains the Extents which have no free page left to be allocated.
        type: list_base_node
      - id: next_segment_id
        doc: 8 bytes which give the first unused segment id
        type: u8
      - id: seg_inodes_full
        doc: list of pages containing segment headers, where all the segment inode slots are reserved
        type: list_base_node
      - id: seg_inodes_free
        doc: list of pages containing segment headers, where not all the segment header slots are reserved
        type: list_base_node

  list_base_node:
    seq:
      - id: list_length
        type: u4
      - id: page_number_of_first_node
        type: u4
      - id: page_offset_of_first_node
        type: u2
      - id: page_number_of_last_node
        type: u4
      - id: page_offset_of_last_node
        type: u2

  xdes_entry:
    seq:
      - id: file_segment_id
        type: u8
        doc: The ID of the file segment to which the extent belongs, if it belongs to a file segment
      - id: list_node
        type: list_node
        doc: Pointers to previous and next extents in a doubly-linked extent descriptor list
      - id: state
        type: u4
        enum: extent_state
      - id: page_state_bitmap
        type: b2
        enum: page_state
        repeat: expr
        repeat-expr: 64
        doc: |
          A bitmap of 2 bits per page in the extent (64 x 2 = 128 bits, or 16 bytes).
          The first bit indicates whether the page is free. The second bit is reserved
          to indicate whether the page is clean (has no un-flushed data), but this bit
          is currently unused and is always set to 1

  list_node:
    seq:
      - id: page_number_of_previous_node
        type: u4
      - id: page_offset_of_previous_node
        type: u2
      - id: page_number_of_next_node
        type: u4
      - id: page_offset_of_next_node
        type: u2

enums:
  extent_state:
    1:
      id: free
      doc: extent is in free list of space
    2:
      id: free_frag
      doc: extent is in free fragment list of space
    3:
      id: full_frag
      doc: extent is in full fragment list of space
    4:
      id: fseg
      doc: extent belongs to a segment

  page_state:
    2: used
    3: free
