// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['kaitai-struct/KaitaiStream'], factory);
  } else if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('kaitai-struct/KaitaiStream'));
  } else {
    root.FileSpaceAddr = factory(root.KaitaiStream);
  }
}(this, function (KaitaiStream) {
var FileSpaceAddr = (function() {
  function FileSpaceAddr(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  FileSpaceAddr.prototype._read = function() {
    this.page = this._io.readU4be();
    this.offset = this._io.readU2be();
  }

  /**
   * page number within a space
   */

  /**
   * byte offset within the page
   */

  return FileSpaceAddr;
})();
return FileSpaceAddr;
}));
