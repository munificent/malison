library malison.terminal;

import 'package:piecemeal/piecemeal.dart';

import 'glyph.dart';

abstract class Terminal {
  int get width;
  int get height;
  Vec get size;

  void clear();
  void write(String text, [Color fore, Color back]);
  void writeAt(int x, int y, String text, [Color fore, Color back]);
  void drawGlyph(int x, int y, Glyph glyph);
  Terminal rect(int x, int y, int width, int height);
}

abstract class RenderableTerminal extends Terminal {
  void render();

  /// Given a point in pixel coordinates, returns the coordinates of the
  /// character that contains that pixel.
  Vec pixelToChar(Vec pixel);
}

class PortTerminal implements Terminal {
  int get width => size.x;
  int get height => size.y;
  final Vec size;

  final int _x;
  final int _y;
  final Terminal _root;

  PortTerminal(this._x, this._y, this.size, this._root);

  void clear() {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        writeAt(x, y, ' ');
      }
    }
  }

  void write(String text, [Color fore, Color back]) {
    // TODO: Bounds test this.
    _root.writeAt(_x, _y, text, fore, back);
  }

  void writeAt(int x, int y, String text, [Color fore, Color back]) {
    // TODO: Bounds test this.
    _root.writeAt(_x + x, _y + y, text, fore, back);
  }

  void drawGlyph(int x, int y, Glyph glyph) {
    if (x < 0) return;
    if (x >= width) return;
    if (y < 0) return;
    if (y >= height) return;

    _root.drawGlyph(_x + x, _y + y, glyph);
  }

  Terminal rect(int x, int y, int width, int height) {
    // TODO(bob): Bounds check.
    return new PortTerminal(_x + x, _y + y, new Vec(width, height), _root);
  }
}
