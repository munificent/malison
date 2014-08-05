library malison.terminal;

import 'package:piecemeal/piecemeal.dart';

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

  /// Clears the terminal to black.
  void clear() {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        drawGlyph(x, y, Glyph.CLEAR);
      }
    }
  }

  /// Writes [text] starting at column [x], row [y] using [fore] as the text
  /// color and [back] as the background color.
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

  Terminal rect(int x, int y, int width, int height) {
    // TODO: Bounds check.
    return new PortTerminal(x, y, new Vec(width, height), this);
  }

  void drawGlyph(int x, int y, Glyph glyph);
}

abstract class RenderableTerminal extends Terminal {
  void render();

  /// Given a point in pixel coordinates, returns the coordinates of the
  /// character that contains that pixel.
  Vec pixelToChar(Vec pixel);
}
