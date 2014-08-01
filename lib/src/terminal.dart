library malison.terminal;

import 'package:piecemeal/piecemeal.dart';

import 'glyph.dart';

abstract class Terminal {
  int get width;
  int get height;
  Vec get size;

  void clear() {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        drawGlyph(x, y, Glyph.CLEAR);
      }
    }
  }

  void write(String text, [Color fore, Color back]) {
    for (int x = 0; x < text.length; x++) {
      if (x >= width) break;
      writeAt(x, 0, text[x], fore, back);
    }
  }

  void writeAt(int x, int y, String text, [Color fore, Color back]) {
    if (fore == null) fore = Color.WHITE;
    if (back == null) back = Color.BLACK;
    // TODO: Bounds check.
    for (var i = 0; i < text.length; i++) {
      if (x + i >= width) break;
      // TODO: Is codeUnits[] the right thing here? Is it fast?
      drawGlyph(x + i, y,
          new Glyph.fromCharCode(text.codeUnits[i], fore, back));
    }
  }

  void drawGlyph(int x, int y, Glyph glyph);
  Terminal rect(int x, int y, int width, int height);
}

abstract class RenderableTerminal extends Terminal {
  void render();

  /// Given a point in pixel coordinates, returns the coordinates of the
  /// character that contains that pixel.
  Vec pixelToChar(Vec pixel);
}

class PortTerminal extends Terminal {
  int get width => size.x;
  int get height => size.y;
  final Vec size;

  final int _x;
  final int _y;
  final Terminal _root;

  PortTerminal(this._x, this._y, this.size, this._root);

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
    // TODO: Bounds check.
    return new PortTerminal(_x + x, _y + y, new Vec(width, height), _root);
  }
}
