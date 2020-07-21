// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['kaitai-struct/KaitaiStream'], factory);
  } else if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('kaitai-struct/KaitaiStream'));
  } else {
    root.FspHdrPageBody = factory(root.KaitaiStream);
  }
}(this, function (KaitaiStream) {
var FspHdrPageBody = (function() {
  FspHdrPageBody.ExtentState = Object.freeze({
    FREE: 1,
    FREE_FRAG: 2,
    FULL_FRAG: 3,
    FSEG: 4,

    1: "FREE",
    2: "FREE_FRAG",
    3: "FULL_FRAG",
    4: "FSEG",
  });

  FspHdrPageBody.PageState = Object.freeze({
    USED: 2,
    FREE: 3,

    2: "USED",
    3: "FREE",
  });

  function FspHdrPageBody(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  FspHdrPageBody.prototype._read = function() {
    this.fspHeader = new FspHeader(this._io, this, this._root);
    this.xdesEntries = new Array(256);
    for (var i = 0; i < 256; i++) {
      this.xdesEntries[i] = new XdesEntry(this._io, this, this._root);
    }
    this.emptySpaces = this._io.readBytes(5986);
  }

  /**
   * @see storage/innobase/include/fsp0fsp.h
   */

  var FspHeader = FspHdrPageBody.FspHeader = (function() {
    function FspHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    FspHeader.prototype._read = function() {
      this.spaceId = this._io.readU4be();
      this.unused = this._io.readBytes(4);
      this.size = this._io.readU4be();
      this.freeLimit = this._io.readU4be();
      this.flags = this._io.readBytes(4);
      this.numberOfPagesUsedInFreeFrag = this._io.readU4be();
      this.free = new ListBaseNode(this._io, this, this._root);
      this.freeFrag = new ListBaseNode(this._io, this, this._root);
      this.fullFrag = new ListBaseNode(this._io, this, this._root);
      this.nextSegmentId = this._io.readU8be();
      this.segInodesFull = new ListBaseNode(this._io, this, this._root);
      this.segInodesFree = new ListBaseNode(this._io, this, this._root);
    }

    /**
     * Current size of the space in pages
     */

    /**
     * Minimum page number for which the free list has not been initialized: the pages >= this limit are,
     * by definition, free; note that in a single-table tablespace where size < 64 pages, this number is
     * 64, i.e., we have initialized the space about the first extent, but have not physically allocted
     * those pages to the file
     */

    /**
     * fsp_space_t.flags, similar to dict_table_t::flags
     */

    /**
     * number of used pages in the FSP_FREE_FRAG list. alas frag_n_used
     */

    /**
     * list of free extents
     */

    /**
     * list of partially free extents not belonging to any segment
     */

    /**
     * list of full extents not belonging to any segment
     */

    /**
     * 8 bytes which give the first unused segment id
     */

    /**
     * list of pages containing segment headers, where all the segment inode slots are reserved
     */

    /**
     * list of pages containing segment headers, where not all the segment header slots are reserved
     */

    return FspHeader;
  })();

  var ListBaseNode = FspHdrPageBody.ListBaseNode = (function() {
    function ListBaseNode(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    ListBaseNode.prototype._read = function() {
      this.listLength = this._io.readU4be();
      this.pageNumberOfFirstNode = this._io.readU4be();
      this.pageOffsetOfFirstNode = this._io.readU2be();
      this.pageNumberOfLastNode = this._io.readU4be();
      this.pageOffsetOfLastNode = this._io.readU2be();
    }

    return ListBaseNode;
  })();

  var XdesEntry = FspHdrPageBody.XdesEntry = (function() {
    function XdesEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    XdesEntry.prototype._read = function() {
      this.fileSegmentId = this._io.readU8be();
      this.listNode = new ListNode(this._io, this, this._root);
      this.state = this._io.readU4be();
      this.pageStateBitmap = new Array(64);
      for (var i = 0; i < 64; i++) {
        this.pageStateBitmap[i] = this._io.readBitsInt(2);
      }
    }

    /**
     * The ID of the file segment to which the extent belongs, if it belongs to a file segment
     */

    /**
     * Pointers to previous and next extents in a doubly-linked extent descriptor list
     */

    /**
     * A bitmap of 2 bits per page in the extent (64 x 2 = 128 bits, or 16 bytes).
     * The first bit indicates whether the page is free. The second bit is reserved
     * to indicate whether the page is clean (has no un-flushed data), but this bit
     * is currently unused and is always set to 1
     */

    return XdesEntry;
  })();

  var ListNode = FspHdrPageBody.ListNode = (function() {
    function ListNode(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    ListNode.prototype._read = function() {
      this.pageNumberOfPreviousNode = this._io.readU4be();
      this.pageOffsetOfPreviousNode = this._io.readU2be();
      this.pageNumberOfNextNode = this._io.readU4be();
      this.pageOffsetOfNextNode = this._io.readU2be();
    }

    return ListNode;
  })();

  return FspHdrPageBody;
})();
return FspHdrPageBody;
}));
