// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['kaitai-struct/KaitaiStream', './Page'], factory);
  } else if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('kaitai-struct/KaitaiStream'), require('./Page'));
  } else {
    root.TableSpace = factory(root.KaitaiStream, root.Page);
  }
}(this, function (KaitaiStream, Page) {
var TableSpace = (function() {
  function TableSpace(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  TableSpace.prototype._read = function() {
    this.pages = [];
    var i = 0;
    while (!this._io.isEof()) {
      this.pages.push(new Page(this._io, this, null));
      i++;
    }
  }

  return TableSpace;
})();
return TableSpace;
}));
