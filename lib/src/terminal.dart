import 'package:piecemeal/piecemeal.dart';

import 'char_code.dart';
import 'glyph.dart';
import 'port_terminal.dart';

/// A virtual console terminal that can be written onto.
abstract class Terminal {
  /// The number of columns of characters.
  int get width;

  /// The number of rows of characters.
  int get height;

  /// The number of columns and rows.
  Vec get size;

  /// The default foreground color used when a color is not specified.
  Color foreColor = Color.white;

  /// The default foreground color used when a color is not specified.
  Color backColor = Color.black;

  /// Clears the terminal to [backColor].
  void clear() {
    fill(0, 0, width, height);
  }

  /// Clears and fills the given rectangle with [color].
  void fill(int x, int y, int width, int height, [Color color]) {
    if (color == null) color = backColor;

    var glyph = Glyph.fromCharCode(CharCode.space, foreColor, color);

    for (var py = y; py < y + height; py++) {
      for (var px = x; px < x + width; px++) {
        drawGlyph(px, py, glyph);
      }
    }
  }

  /// Writes [text] starting at column [x], row [y] using [fore] as the text
  /// color and [back] as the background color.
  void writeAt(int x, int y, String text, [Color fore, Color back]) {
    if (fore == null) fore = foreColor;
    if (back == null) back = backColor;

    // TODO: Bounds check.
    for (var i = 0; i < text.length; i++) {
      if (x + i >= width) break;
      drawGlyph(x + i, y, Glyph.fromCharCode(text.codeUnitAt(i), fore, back));
    }
  }

  Terminal rect(int x, int y, int width, int height) {
    // TODO: Bounds check.
    return PortTerminal(x, y, Vec(width, height), this);
  }

  /// Writes a one-character string consisting of [charCode] at column [x],
  /// row [y] using [fore] as the text color and [back] as the background color.
  void drawChar(int x, int y, int charCode, [Color fore, Color back]) {
    drawGlyph(x, y, Glyph.fromCharCode(charCode, fore, back));
  }

  void drawGlyph(int x, int y, Glyph glyph);
}

abstract class RenderableTerminal extends Terminal {
  void render();

  /// Given a point in pixel coordinates, returns the coordinates of the
  /// character that contains that pixel.
  Vec pixelToChar(Vec pixel);
}
