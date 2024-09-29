import 'dart:html' as html;

import 'package:piecemeal/piecemeal.dart';

import 'char_code.dart';
import 'display.dart';
import 'glyph.dart';
import 'terminal.dart';

/// A [RenderableTerminal] that draws to a canvas element using a browser font.
class CanvasTerminal extends RenderableTerminal {
  final Display _display;

  final Font _font;
  final html.CanvasElement _canvas;
  final html.CanvasRenderingContext2D _context;

  /// The drawing scale, used to adapt to Retina displays.
  final int _scale = html.window.devicePixelRatio.toInt();

  @override
  Vec get size => _display.size;

  @override
  int get width => _display.width;

  @override
  int get height => _display.height;

  factory CanvasTerminal(int width, int height, Font font,
      [html.CanvasElement? canvas]) {
    var display = Display(width, height);

    // If not given a canvas, create one and add it to the page.
    if (canvas == null) {
      canvas = html.CanvasElement();
      html.document.body!.append(canvas);
    }

    return CanvasTerminal._(display, font, canvas);
  }

  CanvasTerminal._(this._display, this._font, this._canvas)
      : _context = _canvas.context2D {
    // Handle high-resolution (i.e. retina) displays.
    var canvasWidth = _font.charWidth * _display.width;
    var canvasHeight = _font.lineHeight * _display.height;
    _canvas.width = canvasWidth * _scale;
    _canvas.height = canvasHeight * _scale;
    _canvas.style.width = '${canvasWidth}px';
    _canvas.style.height = '${canvasHeight}px';
  }

  @override
  void drawGlyph(int x, int y, Glyph glyph) {
    _display.setGlyph(x, y, glyph);
  }

  @override
  void render() {
    _context.font = '${_font.size * _scale}px ${_font.family}, monospace';

    _display.render((x, y, glyph) {
      var char = glyph.char;

      // Fill the background.
      _context.fillStyle = glyph.back.cssColor;
      _context.fillRect(
          x * _font.charWidth * _scale,
          y * _font.lineHeight * _scale,
          _font.charWidth * _scale,
          _font.lineHeight * _scale);

      // Don't bother drawing empty characters.
      if (char == 0 || char == CharCode.space) return;

      _context.fillStyle = glyph.fore.cssColor;
      _context.fillText(
          String.fromCharCodes([char]),
          (x * _font.charWidth + _font.x) * _scale,
          (y * _font.lineHeight + _font.y) * _scale);
    });
  }

  @override
  Vec pixelToChar(Vec pixel) =>
      Vec(pixel.x ~/ _font.charWidth, pixel.y ~/ _font.lineHeight);
}

/// Describes a font used by [CanvasTerminal].
class Font {
  final String family;
  final int size;
  final int charWidth;
  final int lineHeight;
  final int x;
  final int y;

  Font(this.family,
      {required this.size,
      required int w,
      required int h,
      required this.x,
      required this.y})
      : charWidth = w,
        lineHeight = h;
}
