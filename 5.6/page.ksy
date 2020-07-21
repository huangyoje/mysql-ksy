meta:
  id: page
  endian: be
  imports:
    - fsp_hdr_page_body
    - inode_page_body
    - index_page_body
    - ibuf_bitmap_page_body
    - trx_sys_page_body
    - sys_page_body
    - undo_log_page_body

seq:
  - id: header
    type: page_header
  - id: body
    type:
      switch-on: header.page_type
      cases:
        'page_type::index': index_page_body
        'page_type::undo_log': undo_log_page_body
        'page_type::inode': inode_page_body
        'page_type::ibuf_free_list': unkown_page
        'page_type::allocated': unkown_page
        'page_type::ibuf_bitmap': ibuf_bitmap_page_body
        'page_type::sys': sys_page_body
        'page_type::trx_sys': trx_sys_page_body
        'page_type::fsp_hdr': fsp_hdr_page_body
        'page_type::xdes': fsp_hdr_page_body
        'page_type::blob': unkown_page
        'page_type::zblob': unkown_page
        'page_type::zblob2': unkown_page
  - id: trailer
    type: page_trailer

enums:
  page_type:
    17855:
      id: index
      doc: B-tree node
    2:
      id: undo_log
      doc: Undo log page
    3:
      id: inode
      doc: Index node
    4:
      id: ibuf_free_list
      doc: Insert buffer free list
    0:
      id: allocated
      doc: Freshly allocated page
    5:
      id: ibuf_bitmap
      doc: Insert buffer bitmap
    6:
      id: sys
      doc: System page
    7:
      id: trx_sys
      doc: Transaction system data
    8:
      id: fsp_hdr
      doc: File space header
    9:
      id: xdes
      doc: Extent descriptor page
    10:
      id: blob
      doc: Uncompressed BLOB page
    11:
      id: zblob
      doc: First compressed BLOB page
    12:
      id: zblob2
      doc: Subsequent compressed BLOB page

types:
  page_header:
    doc-ref: storage/innobase/include/fil0fil.h
    seq:
      - id: checksum
        doc: the 'new' checksum of the page
        size: 4
      - id: page_number
        doc: page offset inside space
        type: u4
      - id: prev
        doc: |
          if there is a 'natural' predecessor of the page, its offset.  Otherwise FIL_NULL.
          This field is not set on BLOB pages, which are stored as a singly-linked list.
          See also FIL_PAGE_NEXT.
        type: u4
      - id: next
        doc: |
          if there is a 'natural' successor of the page, its offset. Otherwise FIL_NULL.
          B-tree index pages (FIL_PAGE_TYPE contains FIL_PAGE_INDEX) on the same PAGE_LEVEL
          are maintained as a doubly linked list via FIL_PAGE_PREV and FIL_PAGE_NEXT in the
          collation order of the smallest user record on each page.
        type: u4
      - id: lsn
        doc: lsn of the end of the newest modification log record to the page
        type: u8
      - id: page_type
        type: u2
        enum: page_type
      - id: flush_lsn
        doc: |
          this is only defined for the first page in a system tablespace data file (ibdata*,
          not *.ibd): the file has been flushed to disk at least up to this lsn
        type: u8
      - id: space_id
        type: u4

  page_trailer:
    seq:
      - id: old_checksum
        size: 4
      - id: low_lsn
        type: u4

  unkown_page:
    seq:
      - id: content
        size: 16338
