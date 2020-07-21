// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['kaitai-struct/KaitaiStream', './InodePageBody', './FspHdrPageBody'], factory);
  } else if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('kaitai-struct/KaitaiStream'), require('./InodePageBody'), require('./FspHdrPageBody'));
  } else {
    root.Page = factory(root.KaitaiStream, root.InodePageBody, root.FspHdrPageBody);
  }
}(this, function (KaitaiStream, InodePageBody, FspHdrPageBody) {
var Page = (function() {
  Page.PageType = Object.freeze({
    ALLOCATED: 0,
    UNDO_LOG: 2,
    INODE: 3,
    IBUF_FREE_LIST: 4,
    IBUF_BITMAP: 5,
    SYS: 6,
    TRX_SYS: 7,
    FSP_HDR: 8,
    XDES: 9,
    BLOB: 10,
    ZBLOB: 11,
    ZBLOB2: 12,
    INDEX: 17855,

    0: "ALLOCATED",
    2: "UNDO_LOG",
    3: "INODE",
    4: "IBUF_FREE_LIST",
    5: "IBUF_BITMAP",
    6: "SYS",
    7: "TRX_SYS",
    8: "FSP_HDR",
    9: "XDES",
    10: "BLOB",
    11: "ZBLOB",
    12: "ZBLOB2",
    17855: "INDEX",
  });

  function Page(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Page.prototype._read = function() {
    this.header = new PageHeader(this._io, this, this._root);
    switch (this.header.pageType) {
    case Page.PageType.FSP_HDR:
      this.body = new FspHdrPageBody(this._io, this, null);
      break;
    case Page.PageType.BLOB:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.ALLOCATED:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.SYS:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.UNDO_LOG:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.ZBLOB:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.ZBLOB2:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.IBUF_FREE_LIST:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.TRX_SYS:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.INDEX:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    case Page.PageType.XDES:
      this.body = new FspHdrPageBody(this._io, this, null);
      break;
    case Page.PageType.INODE:
      this.body = new InodePageBody(this._io, this, null);
      break;
    case Page.PageType.IBUF_BITMAP:
      this.body = new UnkownPage(this._io, this, this._root);
      break;
    }
    this.trailer = new PageTrailer(this._io, this, this._root);
  }

  /**
   * @see storage/innobase/include/fil0fil.h
   */

  var PageHeader = Page.PageHeader = (function() {
    function PageHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    PageHeader.prototype._read = function() {
      this.checksum = this._io.readBytes(4);
      this.pageOffset = this._io.readU4be();
      this.prev = this._io.readU4be();
      this.next = this._io.readU4be();
      this.lsn = this._io.readU8be();
      this.pageType = this._io.readU2be();
      this.flushLsn = this._io.readU8be();
      this.spaceId = this._io.readU4be();
    }

    /**
     * the 'new' checksum of the page
     */

    /**
     * page offset inside space
     */

    /**
     * if there is a 'natural' predecessor of the page, its offset.  Otherwise FIL_NULL.
     * This field is not set on BLOB pages, which are stored as a singly-linked list.
     * See also FIL_PAGE_NEXT.
     */

    /**
     * if there is a 'natural' successor of the page, its offset. Otherwise FIL_NULL.
     * B-tree index pages (FIL_PAGE_TYPE contains FIL_PAGE_INDEX) on the same PAGE_LEVEL
     * are maintained as a doubly linked list via FIL_PAGE_PREV and FIL_PAGE_NEXT in the
     * collation order of the smallest user record on each page.
     */

    /**
     * lsn of the end of the newest modification log record to the page
     */

    /**
     * this is only defined for the first page in a system tablespace data file (ibdata*,
     * not *.ibd): the file has been flushed to disk at least up to this lsn
     */

    return PageHeader;
  })();

  var PageTrailer = Page.PageTrailer = (function() {
    function PageTrailer(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    PageTrailer.prototype._read = function() {
      this.oldChecksum = this._io.readBytes(4);
      this.lowLsn = this._io.readU4be();
    }

    return PageTrailer;
  })();

  var UnkownPage = Page.UnkownPage = (function() {
    function UnkownPage(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    UnkownPage.prototype._read = function() {
      this.content = this._io.readBytes(16338);
    }

    return UnkownPage;
  })();

  return Page;
})();
return Page;
}));
