library malison.retro_terminal;

import 'dart:html' as html;

import 'package:piecemeal/piecemeal.dart';

import 'glyph.dart';
import 'terminal.dart';

/// Draws to a canvas using the old school DOS [code page 437][font] font. It's
/// got some basic optimization to minimize the amount of drawing it has to do.
///
/// [font]: http://en.wikipedia.org/wiki/Code_page_437
class RetroTerminal extends RenderableTerminal {
  /// The current display state. The glyphs here mirror what has been rendered.
  final Array2D<Glyph> _glyphs;

  /// The glyphs that have been modified since the last call to [render].
  final Array2D<Glyph> _changedGlyphs;

  final html.CanvasElement _canvas;
  html.CanvasRenderingContext2D _context;
  html.ImageElement _font;

  int get width => _glyphs.width;
  int get height => _glyphs.height;
  Vec get size => _glyphs.size;

  /// A cache of the tinted font images. Each key is a color, and the image
  /// will is the font in that color.
  final Map<Color, html.CanvasElement> _fontColorCache = {};

  /// The drawing scale, used to adapt to Retina displays.
  int _scale = 1;

  bool _imageLoaded = false;

  final int _charWidth;
  final int _charHeight;

  // TODO: Make this const when we can use const expressions as keys in
  // map literals.
  static final _unicodeMap = _createUnicodeMap();

  /// Creates a new terminal using a built-in DOS-like font.
  RetroTerminal.dos(int width, int height, html.CanvasElement canvas)
      : this(width, height, canvas, "packages/malison/dos.png",
            charWidth: 9, charHeight: 16);

  /// Creates a new terminal using a short built-in DOS-like font.
  RetroTerminal.shortDos(int width, int height, html.CanvasElement canvas)
      : this(width, height, canvas, "packages/malison/dos-short.png",
            charWidth: 9, charHeight: 13);

  /// Creates a new terminal using a font image at [imageUrl].
  RetroTerminal(int width, int height, this._canvas, String imageUrl,
      {int charWidth, int charHeight})
      : _glyphs = new Array2D<Glyph>(width, height),
        _changedGlyphs = new Array2D<Glyph>(width, height, Glyph.CLEAR),
        _charWidth = charWidth,
        _charHeight = charHeight {
    _context = _canvas.context2D;

    // Handle high-resolution (i.e. retina) displays.
    if (html.window.devicePixelRatio > 1) {
      _scale = 2;
    }

    var canvasWidth = _charWidth * width;
    var canvasHeight = _charHeight * height;
    _canvas.width = canvasWidth * _scale;
    _canvas.height = canvasHeight * _scale;
    _canvas.style.width = '${canvasWidth}px';
    _canvas.style.height = '${canvasHeight}px';

    _font = new html.ImageElement(src: imageUrl);
    _font.onLoad.listen((_) {
      _imageLoaded = true;
      render();
    });
  }

  static Map<int, int> _createUnicodeMap() {
    var map = new Map<int, int>();
    map[CharCode.BULLET] = 7;
    map[CharCode.UP_DOWN_ARROW] = 18;
    map[CharCode.LEFT_RIGHT_ARROW] = 29;
    map[CharCode.BLACK_UP_POINTING_TRIANGLE] = 30;
    map[CharCode.BLACK_SPADE_SUIT] = 6;
    map[CharCode.BLACK_CLUB_SUIT] = 5;
    map[CharCode.SOLID] = 219;
    map[CharCode.HALF_LEFT] = 221;
    map[CharCode.BOX_DRAWINGS_LIGHT_VERTICAL] = 179;
    map[CharCode.TRIPLE_BAR] = 240;
    map[CharCode.PI] = 227;
    map[CharCode.BLACK_HEART_SUIT] = 3;
    return map;
  }

  void drawGlyph(int x, int y, Glyph glyph) {
    if (x < 0) return;
    if (x >= width) return;
    if (y < 0) return;
    if (y >= height) return;

    if (_glyphs.get(x, y) != glyph) {
      _changedGlyphs.set(x, y, glyph);
    } else {
      _changedGlyphs.set(x, y, null);
    }
  }

  Terminal rect(int x, int y, int width, int height) {
    // TODO: Bounds check.
    return new PortTerminal(x, y, new Vec(width, height), this);
  }

  void render() {
    if (!_imageLoaded) return;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        var glyph = _changedGlyphs.get(x, y);

        // Only draw glyphs that are different since the last call.
        if (glyph == null) continue;

        // Up to date now.
        _glyphs.set(x, y, glyph);
        _changedGlyphs.set(x, y, null);

        var char = glyph.char;

        // See if it's a Unicode character that needs to be remapped.
        var fromUnicode = _unicodeMap[char];
        if (fromUnicode != null) char = fromUnicode;

        var sx = (char % 32) * _charWidth;
        var sy = (char ~/ 32) * _charHeight;

        // Fill the background.
        _context.fillStyle = glyph.back.cssColor;
        _context.fillRect(
            x * _charWidth * _scale,
            y * _charHeight * _scale,
            _charWidth * _scale,
            _charHeight * _scale);

        // Don't bother drawing empty characters.
        if (char == 0 || char == CharCode.SPACE) continue;

        var color = _getColorFont(glyph.fore);
        // *2 because the font image is double-sized. That ensures it stays
        // sharp on retina displays and doesn't render scaled up.
        _context.drawImageScaledFromSource(color,
            sx * 2, sy * 2, _charWidth * 2, _charHeight * 2,
            x * _charWidth * _scale,
            y * _charHeight * _scale,
            _charWidth * _scale,
            _charHeight * _scale);
      }
    }
  }

  Vec pixelToChar(Vec pixel) =>
      new Vec(pixel.x ~/ _charWidth, pixel.y ~/ _charHeight);

  html.CanvasElement _getColorFont(Color color) {
    var cached = _fontColorCache[color];
    if (cached != null) return cached;

    // Create a font using the given color.
    var tint = new html.CanvasElement(width: _font.width, height: _font.height);
    var context = tint.context2D;

    // Draw the font.
    context.drawImage(_font, 0, 0);

    // Tint it by filling in the existing alpha with the color.
    context.globalCompositeOperation = 'source-atop';
    context.fillStyle = color.cssColor;
    context.fillRect(0, 0, _font.width, _font.height);

    _fontColorCache[color] = tint;
    return tint;
  }
}
