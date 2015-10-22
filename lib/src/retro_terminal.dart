library malison.retro_terminal;

import 'dart:html' as html;

import 'package:piecemeal/piecemeal.dart';

import 'char_code.dart';
import 'glyph.dart';
import 'display.dart';
import 'terminal.dart';

/// A [RenderableTerminal] that draws to a canvas using the old school DOS
/// [code page 437][font] font.
///
/// [font]: http://en.wikipedia.org/wiki/Code_page_437
class RetroTerminal extends RenderableTerminal {
  final Display _display;

  final html.CanvasElement _canvas;
  final html.CanvasRenderingContext2D _context;
  final html.ImageElement _font;

  /// A cache of the tinted font images. Each key is a color, and the image
  /// will is the font in that color.
  final Map<Color, html.CanvasElement> _fontColorCache = {};

  /// The drawing scale, used to adapt to Retina displays.
  final int _scale = html.window.devicePixelRatio.toInt();

  bool _imageLoaded = false;

  final int _charWidth;
  final int _charHeight;

  int get width => _display.width;
  int get height => _display.height;
  Vec get size => _display.size;

  static final _UNICODE_MAP = const {
    // 1 - 15.
    CharCode.WHITE_SMILING_FACE: 1,
    CharCode.BLACK_SMILING_FACE: 2,
    CharCode.BLACK_HEART_SUIT: 3,
    CharCode.BLACK_DIAMOND_SUIT: 4,
    CharCode.BLACK_CLUB_SUIT: 5,
    CharCode.BLACK_SPADE_SUIT: 6,
    CharCode.BULLET: 7,
    CharCode.INVERSE_BULLET: 8,
    CharCode.WHITE_CIRCLE: 9,
    CharCode.INVERSE_WHITE_CIRCLE: 10,
    CharCode.MALE_SIGN: 11,
    CharCode.FEMALE_SIGN: 12,
    CharCode.EIGHTH_NOTE: 13,
    CharCode.BEAMED_EIGHTH_NOTES: 14,
    CharCode.WHITE_SUN_WITH_RAYS: 15,

    // 16 - 31.
    CharCode.BLACK_RIGHT_POINTING_POINTER: 16,
    CharCode.BLACK_LEFT_POINTING_POINTER: 17,
    CharCode.UP_DOWN_ARROW: 18,
    CharCode.DOUBLE_EXCLAMATION_MARK: 19,
    CharCode.PILCROW: 20,
    CharCode.SECTION_SIGN: 21,
    CharCode.BLACK_RECTANGLE: 22,
    CharCode.UP_DOWN_ARROW_WITH_BASE: 23,
    CharCode.UPWARDS_ARROW: 24,
    CharCode.DOWNWARDS_ARROW: 25,
    CharCode.RIGHTWARDS_ARROW: 26,
    CharCode.LEFTWARDS_ARROW: 27,
    CharCode.RIGHT_ANGLE: 28,
    CharCode.LEFT_RIGHT_ARROW: 29,
    CharCode.BLACK_UP_POINTING_TRIANGLE: 30,
    CharCode.BLACK_DOWN_POINTING_TRIANGLE: 31,

    // 127.
    CharCode.HOUSE: 127,

    // 128 - 143.
    CharCode.LATIN_CAPITAL_LETTER_C_WITH_CEDILLA: 128,
    CharCode.LATIN_SMALL_LETTER_U_WITH_DIAERESIS: 129,
    CharCode.LATIN_SMALL_LETTER_E_WITH_ACUTE: 130,
    CharCode.LATIN_SMALL_LETTER_A_WITH_CIRCUMFLEX: 131,
    CharCode.LATIN_SMALL_LETTER_A_WITH_DIAERESIS: 132,
    CharCode.LATIN_SMALL_LETTER_A_WITH_GRAVE: 133,
    CharCode.LATIN_SMALL_LETTER_A_WITH_RING_ABOVE: 134,
    CharCode.LATIN_SMALL_LETTER_C_WITH_CEDILLA: 135,
    CharCode.LATIN_SMALL_LETTER_E_WITH_CIRCUMFLEX: 136,
    CharCode.LATIN_SMALL_LETTER_E_WITH_DIAERESIS: 137,
    CharCode.LATIN_SMALL_LETTER_E_WITH_GRAVE: 138,
    CharCode.LATIN_SMALL_LETTER_I_WITH_DIAERESIS: 139,
    CharCode.LATIN_SMALL_LETTER_I_WITH_CIRCUMFLEX: 140,
    CharCode.LATIN_SMALL_LETTER_I_WITH_GRAVE: 141,
    CharCode.LATIN_CAPITAL_LETTER_A_WITH_DIAERESIS: 142,
    CharCode.LATIN_CAPITAL_LETTER_A_WITH_RING_ABOVE: 143,

    // 144 - 159.
    CharCode.LATIN_CAPITAL_LETTER_E_WITH_ACUTE: 144,
    CharCode.LATIN_SMALL_LETTER_AE: 145,
    CharCode.LATIN_CAPITAL_LETTER_AE: 146,
    CharCode.LATIN_SMALL_LETTER_O_WITH_CIRCUMFLEX: 147,
    CharCode.LATIN_SMALL_LETTER_O_WITH_DIAERESIS: 148,
    CharCode.LATIN_SMALL_LETTER_O_WITH_GRAVE: 149,
    CharCode.LATIN_SMALL_LETTER_U_WITH_CIRCUMFLEX: 150,
    CharCode.LATIN_SMALL_LETTER_U_WITH_GRAVE: 151,
    CharCode.LATIN_SMALL_LETTER_Y_WITH_DIAERESIS: 152,
    CharCode.LATIN_CAPITAL_LETTER_O_WITH_DIAERESIS: 153,
    CharCode.LATIN_CAPITAL_LETTER_U_WITH_DIAERESIS: 154,
    CharCode.CENT_SIGN: 155,
    CharCode.POUND_SIGN: 156,
    CharCode.YEN_SIGN: 157,
    CharCode.PESETA_SIGN: 158,
    CharCode.LATIN_SMALL_LETTER_F_WITH_HOOK: 159,

    // 160 - 175.
    CharCode.LATIN_SMALL_LETTER_A_WITH_ACUTE: 160,
    CharCode.LATIN_SMALL_LETTER_I_WITH_ACUTE: 161,
    CharCode.LATIN_SMALL_LETTER_O_WITH_ACUTE: 162,
    CharCode.LATIN_SMALL_LETTER_U_WITH_ACUTE: 163,
    CharCode.LATIN_SMALL_LETTER_N_WITH_TILDE: 164,
    CharCode.LATIN_CAPITAL_LETTER_N_WITH_TILDE: 165,
    CharCode.FEMININE_ORDINAL_INDICATOR: 166,
    CharCode.MASCULINE_ORDINAL_INDICATOR: 167,
    CharCode.INVERTED_QUESTION_MARK: 168,
    CharCode.REVERSED_NOT_SIGN: 169,
    CharCode.NOT_SIGN: 170,
    CharCode.VULGAR_FRACTION_ONE_HALF: 171,
    CharCode.VULGAR_FRACTION_ONE_QUARTER: 172,
    CharCode.INVERTED_EXCLAMATION_MARK: 173,
    CharCode.LEFT_POINTING_DOUBLE_ANGLE_QUOTATION_MARK: 174,
    CharCode.RIGHT_POINTING_DOUBLE_ANGLE_QUOTATION_MARK: 175,

    // 176 - 191.
    CharCode.LIGHT_SHADE: 176,
    CharCode.MEDIUM_SHADE: 177,
    CharCode.DARK_SHADE: 178,
    CharCode.BOX_DRAWINGS_LIGHT_VERTICAL: 179,
    CharCode.BOX_DRAWINGS_LIGHT_VERTICAL_AND_LEFT: 180,
    CharCode.BOX_DRAWINGS_VERTICAL_SINGLE_AND_LEFT_DOUBLE: 181,
    CharCode.BOX_DRAWINGS_VERTICAL_DOUBLE_AND_LEFT_SINGLE: 182,
    CharCode.BOX_DRAWINGS_DOWN_DOUBLE_AND_LEFT_SINGLE: 183,
    CharCode.BOX_DRAWINGS_DOWN_SINGLE_AND_LEFT_DOUBLE: 184,
    CharCode.BOX_DRAWINGS_DOUBLE_VERTICAL_AND_LEFT: 185,
    CharCode.BOX_DRAWINGS_DOUBLE_VERTICAL: 186,
    CharCode.BOX_DRAWINGS_DOUBLE_DOWN_AND_LEFT: 187,
    CharCode.BOX_DRAWINGS_DOUBLE_UP_AND_LEFT: 188,
    CharCode.BOX_DRAWINGS_UP_DOUBLE_AND_LEFT_SINGLE: 189,
    CharCode.BOX_DRAWINGS_UP_SINGLE_AND_LEFT_DOUBLE: 190,
    CharCode.BOX_DRAWINGS_LIGHT_DOWN_AND_LEFT: 191,

    // 192 - 207.
    CharCode.BOX_DRAWINGS_LIGHT_UP_AND_RIGHT: 192,
    CharCode.BOX_DRAWINGS_LIGHT_UP_AND_HORIZONTAL: 193,
    CharCode.BOX_DRAWINGS_LIGHT_DOWN_AND_HORIZONTAL: 194,
    CharCode.BOX_DRAWINGS_LIGHT_VERTICAL_AND_RIGHT: 195,
    CharCode.BOX_DRAWINGS_LIGHT_HORIZONTAL: 196,
    CharCode.BOX_DRAWINGS_LIGHT_VERTICAL_AND_HORIZONTAL: 197,
    CharCode.BOX_DRAWINGS_VERTICAL_SINGLE_AND_RIGHT_DOUBLE: 198,
    CharCode.BOX_DRAWINGS_VERTICAL_DOUBLE_AND_RIGHT_SINGLE: 199,
    CharCode.BOX_DRAWINGS_DOUBLE_UP_AND_RIGHT: 200,
    CharCode.BOX_DRAWINGS_DOUBLE_DOWN_AND_RIGHT: 201,
    CharCode.BOX_DRAWINGS_DOUBLE_UP_AND_HORIZONTAL: 202,
    CharCode.BOX_DRAWINGS_DOUBLE_DOWN_AND_HORIZONTAL: 203,
    CharCode.BOX_DRAWINGS_DOUBLE_VERTICAL_AND_RIGHT: 204,
    CharCode.BOX_DRAWINGS_DOUBLE_HORIZONTAL: 205,
    CharCode.BOX_DRAWINGS_DOUBLE_VERTICAL_AND_HORIZONTAL: 206,
    CharCode.BOX_DRAWINGS_UP_SINGLE_AND_HORIZONTAL_DOUBLE: 207,

    // 208 - 223.
    CharCode.BOX_DRAWINGS_UP_DOUBLE_AND_HORIZONTAL_SINGLE: 208,
    CharCode.BOX_DRAWINGS_DOWN_SINGLE_AND_HORIZONTAL_DOUBLE: 209,
    CharCode.BOX_DRAWINGS_DOWN_DOUBLE_AND_HORIZONTAL_SINGLE: 210,
    CharCode.BOX_DRAWINGS_UP_DOUBLE_AND_RIGHT_SINGLE: 211,
    CharCode.BOX_DRAWINGS_UP_SINGLE_AND_RIGHT_DOUBLE: 212,
    CharCode.BOX_DRAWINGS_DOWN_SINGLE_AND_RIGHT_DOUBLE: 213,
    CharCode.BOX_DRAWINGS_DOWN_DOUBLE_AND_RIGHT_SINGLE: 214,
    CharCode.BOX_DRAWINGS_VERTICAL_DOUBLE_AND_HORIZONTAL_SINGLE: 215,
    CharCode.BOX_DRAWINGS_VERTICAL_SINGLE_AND_HORIZONTAL_DOUBLE: 216,
    CharCode.BOX_DRAWINGS_LIGHT_UP_AND_LEFT: 217,
    CharCode.BOX_DRAWINGS_LIGHT_DOWN_AND_RIGHT: 218,
    CharCode.FULL_BLOCK: 219,
    CharCode.LOWER_HALF_BLOCK: 220,
    CharCode.LEFT_HALF_BLOCK: 221,
    CharCode.RIGHT_HALF_BLOCK: 222,
    CharCode.UPPER_HALF_BLOCK: 223,

    // 224 - 239.
    CharCode.GREEK_SMALL_LETTER_ALPHA: 224,
    CharCode.LATIN_SMALL_LETTER_SHARP_S: 225,
    CharCode.GREEK_CAPITAL_LETTER_GAMMA: 226,
    CharCode.GREEK_SMALL_LETTER_PI: 227,
    CharCode.GREEK_CAPITAL_LETTER_SIGMA: 228,
    CharCode.GREEK_SMALL_LETTER_SIGMA: 229,
    CharCode.MICRO_SIGN: 230,
    CharCode.GREEK_SMALL_LETTER_TAU: 231,
    CharCode.GREEK_CAPITAL_LETTER_PHI: 232,
    CharCode.GREEK_CAPITAL_LETTER_THETA: 233,
    CharCode.GREEK_CAPITAL_LETTER_OMEGA: 234,
    CharCode.GREEK_SMALL_LETTER_DELTA: 235,
    CharCode.INFINITY: 236,
    CharCode.GREEK_SMALL_LETTER_PHI: 237,
    CharCode.GREEK_SMALL_LETTER_EPSILON: 238,
    CharCode.INTERSECTION: 239,

    // 240 - 255.
    CharCode.IDENTICAL_TO: 240,
    CharCode.PLUS_MINUS_SIGN: 241,
    CharCode.GREATER_THAN_OR_EQUAL_TO: 242,
    CharCode.LESS_THAN_OR_EQUAL_TO: 243,
    CharCode.TOP_HALF_INTEGRAL: 244,
    CharCode.BOTTOM_HALF_INTEGRAL: 245,
    CharCode.DIVISION_SIGN: 246,
    CharCode.ALMOST_EQUAL_TO: 247,
    CharCode.DEGREE_SIGN: 248,
    CharCode.BULLET_OPERATOR: 249,
    CharCode.MIDDLE_DOT: 250,
    CharCode.SQUARE_ROOT: 251,
    CharCode.SUPERSCRIPT_LATIN_SMALL_LETTER_N: 252,
    CharCode.SUPERSCRIPT_TWO: 253,
    CharCode.BLACK_SQUARE: 254
  };

  /// Creates a new terminal using a built-in DOS-like font.
  factory RetroTerminal.dos(int width, int height,
          [html.CanvasElement canvas]) =>
      new RetroTerminal(width, height, "packages/malison/dos.png",
          canvas: canvas, charWidth: 9, charHeight: 16);

  /// Creates a new terminal using a short built-in DOS-like font.
  factory RetroTerminal.shortDos(int width, int height,
          [html.CanvasElement canvas]) =>
      new RetroTerminal(width, height, "packages/malison/dos-short.png",
          canvas: canvas, charWidth: 9, charHeight: 13);

  /// Creates a new terminal using a font image at [imageUrl].
  factory RetroTerminal(int width, int height, String imageUrl,
      {html.CanvasElement canvas, int charWidth, int charHeight}) {
    // If not given a canvas, create one and add it to the page.
    if (canvas == null) {
      canvas = new html.CanvasElement();
      html.document.body.append(canvas);
    }

    var display = new Display(width, height);

    return new RetroTerminal._(display, charWidth, charHeight, canvas,
        new html.ImageElement(src: imageUrl));
  }

  RetroTerminal._(this._display, this._charWidth, this._charHeight,
      html.CanvasElement canvas, this._font)
      : _canvas = canvas,
        _context = canvas.context2D {
    var canvasWidth = _charWidth * _display.width;
    var canvasHeight = _charHeight * _display.height;
    _canvas.width = canvasWidth * _scale;
    _canvas.height = canvasHeight * _scale;
    _canvas.style.width = '${canvasWidth}px';
    _canvas.style.height = '${canvasHeight}px';

    _font.onLoad.listen((_) {
      _imageLoaded = true;
      render();
    });
  }

  void drawGlyph(int x, int y, Glyph glyph) {
    _display.setGlyph(x, y, glyph);
  }

  void render() {
    if (!_imageLoaded) return;

    _display.render((x, y, glyph) {
      var char = glyph.char;

      // See if it's a Unicode character that needs to be remapped.
      var fromUnicode = _UNICODE_MAP[char];
      if (fromUnicode != null) char = fromUnicode;

      var sx = (char % 32) * _charWidth;
      var sy = (char ~/ 32) * _charHeight;

      // Fill the background.
      _context.fillStyle = glyph.back.cssColor;
      _context.fillRect(x * _charWidth * _scale, y * _charHeight * _scale,
          _charWidth * _scale, _charHeight * _scale);

      // Don't bother drawing empty characters.
      if (char == 0 || char == CharCode.SPACE) return;

      var color = _getColorFont(glyph.fore);
      // * 2 because the font image is double-sized. That ensures it stays
      // sharp on retina displays and doesn't render scaled up.
      _context.drawImageScaledFromSource(
          color,
          sx * 2,
          sy * 2,
          _charWidth * 2,
          _charHeight * 2,
          x * _charWidth * _scale,
          y * _charHeight * _scale,
          _charWidth * _scale,
          _charHeight * _scale);
    });
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
