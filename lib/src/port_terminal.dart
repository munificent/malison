import 'package:piecemeal/piecemeal.dart';

import 'glyph.dart';
import 'terminal.dart';

/// A terminal that draws to a window within another parent terminal.
class PortTerminal extends Terminal {
  int get width => size.x;
  int get height => size.y;
  final Vec size;

  final int _x;
  final int _y;
  final Terminal _root;

  PortTerminal(this._x, this._y, this.size, this._root);

  void drawGlyph(int x, int y, Glyph glyph) {
    if (x < 0) return;
    if (x >= width) return;
    if (y < 0) return;
    if (y >= height) return;

    _root.drawGlyph(_x + x, _y + y, glyph);
  }

  Terminal rect(int x, int y, int width, int height) {
    // TODO: Bounds check.
    // Overridden so we can flatten out nested PortTerminals.
    return PortTerminal(_x + x, _y + y, Vec(width, height), _root);
  }
}
