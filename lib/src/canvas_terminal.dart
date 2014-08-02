library malison.canvas_terminal;

import 'dart:html' as html;

import 'package:piecemeal/piecemeal.dart';

import 'glyph.dart';
import 'display.dart';
import 'terminal.dart';

/// A [RenderableTerminal] that draws to a canvas element using a browser font.
class CanvasTerminal extends RenderableTerminal {
  final Display _display;

  final Font font;
  final html.CanvasElement canvas;
  html.CanvasRenderingContext2D context;

  int scale = 1;

  Vec get size => _display.size;
  int get width => _display.width;
  int get height => _display.height;

  CanvasTerminal(int width, int height, this.canvas, this.font)
      : _display = new Display(width, height) {
    context = canvas.context2D;

    canvas.width = font.charWidth * width;
    canvas.height = font.lineHeight * height;

    // Handle high-resolution (i.e. retina) displays.
    if (html.window.devicePixelRatio > 1) {
      scale = 2;

      canvas.style.width = '${font.charWidth * width / scale}px';
      canvas.style.height = '${font.lineHeight * height / scale}px';
    }
  }

  void drawGlyph(int x, int y, Glyph glyph) {
    _display.setGlyph(x, y, glyph);
  }

  void render() {
    context.font = '${font.size * scale}px ${font.family}, monospace';

    _display.render((x, y, glyph) {
      var char = glyph.char;

      // Fill the background.
      context.fillStyle = glyph.back.cssColor;
      context.fillRect(x * font.charWidth, y * font.lineHeight,
          font.charWidth, font.lineHeight);

      // Don't bother drawing empty characters.
      if (char == 0 || char == CharCode.SPACE) return;

      context.fillStyle = glyph.fore.cssColor;
      context.fillText(new String.fromCharCodes([char]),
          x * font.charWidth + font.x, y * font.lineHeight + font.y);
    });
  }

  Vec pixelToChar(Vec pixel) =>
      new Vec(pixel.x ~/ font.charWidth, pixel.y ~/ font.lineHeight);
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