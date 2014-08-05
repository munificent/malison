library malison.canvas_terminal;

import 'dart:html' as html;

import 'package:piecemeal/piecemeal.dart';

import 'glyph.dart';
import 'display.dart';
import 'terminal.dart';

/// A [RenderableTerminal] that draws to a canvas element using a browser font.
class CanvasTerminal extends RenderableTerminal {
  final Display _display;

  final Font _font;
  final html.CanvasElement _canvas;
  html.CanvasRenderingContext2D _context;

  int _scale = 1;

  Vec get size => _display.size;
  int get width => _display.width;
  int get height => _display.height;

  CanvasTerminal(int width, int height, this._canvas, this._font)
      : _display = new Display(width, height) {
    _context = _canvas.context2D;

    _canvas.width = _font.charWidth * width;
    _canvas.height = _font.lineHeight * height;

    // Handle high-resolution (i.e. retina) displays.
    if (html.window.devicePixelRatio > 1) {
      _scale = 2;

      _canvas.style.width = '${_font.charWidth * width / _scale}px';
      _canvas.style.height = '${_font.lineHeight * height / _scale}px';
    }
  }

  void drawGlyph(int x, int y, Glyph glyph) {
    _display.setGlyph(x, y, glyph);
  }

  void render() {
    _context.font = '${_font.size * _scale}px ${_font.family}, monospace';

    _display.render((x, y, glyph) {
      var char = glyph.char;

      // Fill the background.
      _context.fillStyle = glyph.back.cssColor;
      _context.fillRect(x * _font.charWidth, y * _font.lineHeight,
          _font.charWidth, _font.lineHeight);

      // Don't bother drawing empty characters.
      if (char == 0 || char == CharCode.SPACE) return;

      _context.fillStyle = glyph.fore.cssColor;
      _context.fillText(new String.fromCharCodes([char]),
          x * _font.charWidth + _font.x, y * _font.lineHeight + _font.y);
    });
  }

  Vec pixelToChar(Vec pixel) =>
      new Vec(pixel.x ~/ _font.charWidth, pixel.y ~/ _font.lineHeight);
}

/// Describes a font used by [CanvasTerminal].
class Font {
  final String family;
  final int size;
  final int charWidth;
  final int lineHeight;
  final int x;
  final int y;

  Font(this.family, {this.size, int w, int h, this.x, this.y})
      : charWidth = w,
        lineHeight = h;
}