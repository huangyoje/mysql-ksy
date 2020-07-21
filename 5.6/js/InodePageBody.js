// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['kaitai-struct/KaitaiStream', './FileSpaceAddr'], factory);
  } else if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('kaitai-struct/KaitaiStream'), require('./FileSpaceAddr'));
  } else {
    root.InodePageBody = factory(root.KaitaiStream, root.FileSpaceAddr);
  }
}(this, function (KaitaiStream, FileSpaceAddr) {
var InodePageBody = (function() {
  function InodePageBody(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  InodePageBody.prototype._read = function() {
    this.inodePageList = new ListNode(this._io, this, this._root);
    this.inodeEntries = new Array(85);
    for (var i = 0; i < 85; i++) {
      this.inodeEntries[i] = new InodeEntry(this._io, this, this._root);
    }
    this.emptySpaces = this._io.readBytes(6);
  }

  var InodeEntry = InodePageBody.InodeEntry = (function() {
    function InodeEntry(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    InodeEntry.prototype._read = function() {
      this.fsegId = this._io.readU8be();
      this.numberOfUsedPagesInNotFullList = this._io.readU4be();
      this.listBaseNodeForFreeList = new ListBaseNode(this._io, this, this._root);
      this.listBaseNodeForNotFullList = new ListBaseNode(this._io, this, this._root);
      this.listBaseNodeForFullList = new ListBaseNode(this._io, this, this._root);
      this.magicNumber = this._io.readU4be();
      this.fsegFragArr = new Array(32);
      for (var i = 0; i < 32; i++) {
        this.fsegFragArr[i] = this._io.readBytes(4);
      }
    }

    return InodeEntry;
  })();

  var ListBaseNode = InodePageBody.ListBaseNode = (function() {
    function ListBaseNode(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    ListBaseNode.prototype._read = function() {
      this.listLength = this._io.readU4be();
      this.firstNode = new FileSpaceAddr(this._io, this, null);
      this.lastNode = new FileSpaceAddr(this._io, this, null);
    }

    return ListBaseNode;
  })();

  var ListNode = InodePageBody.ListNode = (function() {
    function ListNode(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root || this;

      this._read();
    }
    ListNode.prototype._read = function() {
      this.previousNode = new FileSpaceAddr(this._io, this, null);
      this.nextNode = new FileSpaceAddr(this._io, this, null);
    }

    return ListNode;
  })();

  return InodePageBody;
})();
return InodePageBody;
}));
