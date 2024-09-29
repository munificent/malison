import 'dart:html' as html;

import 'package:piecemeal/piecemeal.dart';

import 'char_code.dart';
import 'glyph.dart';
import 'display.dart';
import 'terminal.dart';
import 'unicode_map.dart';

/// A [RenderableTerminal] that draws to a canvas using the old school DOS
/// [code page 437][font] font.
///
/// [font]: http://en.wikipedia.org/wiki/Code_page_437
class RetroTerminal extends RenderableTerminal {
  final Display _display;

  final html.CanvasRenderingContext2D _context;
  final html.ImageElement _font;

  /// A cache of the tinted font images. Each key is a color, and the image
  /// will is the font in that color.
  final Map<Color, html.CanvasElement> _fontColorCache = {};

  /// The drawing scale, used to adapt to Retina displays.
  final int _scale;

  bool _imageLoaded = false;

  final int _charWidth;
  final int _charHeight;

  @override
  int get width => _display.width;

  @override
  int get height => _display.height;

  @override
  Vec get size => _display.size;

  /// Creates a new terminal using a built-in DOS-like font.
  factory RetroTerminal.dos(int width, int height,
          [html.CanvasElement? canvas]) =>
      RetroTerminal(width, height, "packages/malison/dos.png",
          canvas: canvas, charWidth: 9, charHeight: 16);

  /// Creates a new terminal using a short built-in DOS-like font.
  factory RetroTerminal.shortDos(int width, int height,
          [html.CanvasElement? canvas]) =>
      RetroTerminal(width, height, "packages/malison/dos-short.png",
          canvas: canvas, charWidth: 9, charHeight: 13);

  /// Creates a new terminal using a font image at [imageUrl].
  factory RetroTerminal(int width, int height, String imageUrl,
      {html.CanvasElement? canvas,
      required int charWidth,
      required int charHeight,
      int? scale}) {
    scale ??= html.window.devicePixelRatio.toInt();

    // If not given a canvas, create one, automatically size it, and add it to
    // the page.
    if (canvas == null) {
      canvas = html.CanvasElement();
      var canvasWidth = charWidth * width;
      var canvasHeight = charHeight * height;
      canvas.width = canvasWidth * scale;
      canvas.height = canvasHeight * scale;
      canvas.style.width = '${canvasWidth}px';
      canvas.style.height = '${canvasHeight}px';

      html.document.body!.append(canvas);
    }

    var display = Display(width, height);

    return RetroTerminal._(display, charWidth, charHeight, canvas,
        html.ImageElement(src: imageUrl), scale);
  }

  RetroTerminal._(this._display, this._charWidth, this._charHeight,
      html.CanvasElement canvas, this._font, this._scale)
      : _context = canvas.context2D {
    _font.onLoad.listen((_) {
      _imageLoaded = true;
      render();
    });
  }

  @override
  void drawGlyph(int x, int y, Glyph glyph) {
    _display.setGlyph(x, y, glyph);
  }

  @override
  void render() {
    if (!_imageLoaded) return;

    _display.render((x, y, glyph) {
      var char = glyph.char;

      // Remap it if it's a Unicode character.
      char = unicodeMap[char] ?? char;

      var sx = (char % 32) * _charWidth;
      var sy = (char ~/ 32) * _charHeight;

      // Fill the background.
      _context.fillStyle = glyph.back.cssColor;
      _context.fillRect(x * _charWidth * _scale, y * _charHeight * _scale,
          _charWidth * _scale, _charHeight * _scale);

      // Don't bother drawing empty characters.
      if (char == 0 || char == CharCode.space) return;

      var color = _getColorFont(glyph.fore);
      _context.imageSmoothingEnabled = false;
      _context.drawImageScaledFromSource(
          color,
          sx,
          sy,
          _charWidth,
          _charHeight,
          x * _charWidth * _scale,
          y * _charHeight * _scale,
          _charWidth * _scale,
          _charHeight * _scale);
    });
  }

  @override
  Vec pixelToChar(Vec pixel) =>
      Vec(pixel.x ~/ _charWidth, pixel.y ~/ _charHeight);

  html.CanvasElement _getColorFont(Color color) {
    var cached = _fontColorCache[color];
    if (cached != null) return cached;

    // Create a font using the given color.
    var tint = html.CanvasElement(width: _font.width, height: _font.height);
    var context = tint.context2D;

    // Draw the font.
    context.drawImage(_font, 0, 0);

    // Tint it by filling in the existing alpha with the color.
    context.globalCompositeOperation = 'source-atop';
    context.fillStyle = color.cssColor;
    context.fillRect(0, 0, _font.width!, _font.height!);

    _fontColorCache[color] = tint;
    return tint;
  }
}
