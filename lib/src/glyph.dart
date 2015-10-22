library malison.glyph;

import 'char_code.dart';

class Color {
  static const BLACK        = const Color('#000');
  static const WHITE        = const Color('#fff');

  static const LIGHT_GRAY   = const Color('rgb(192, 192, 192)');
  static const GRAY         = const Color('rgb(128, 128, 128)');
  static const DARK_GRAY    = const Color('rgb(64, 64, 64)');

  static const LIGHT_RED    = const Color('rgb(255, 160, 160)');
  static const RED          = const Color('rgb(220, 0, 0)');
  static const DARK_RED     = const Color('rgb(100, 0, 0)');

  static const LIGHT_ORANGE = const Color('rgb(255, 200, 170)');
  static const ORANGE       = const Color('rgb(255, 128, 0)');
  static const DARK_ORANGE  = const Color('rgb(128, 64, 0)');

  static const LIGHT_GOLD   = const Color('rgb(255, 230, 150)');
  static const GOLD         = const Color('rgb(255, 192, 0)');
  static const DARK_GOLD    = const Color('rgb(128, 96, 0)');

  static const LIGHT_YELLOW = const Color('rgb(255, 255, 150)');
  static const YELLOW       = const Color('rgb(255, 255, 0)');
  static const DARK_YELLOW  = const Color('rgb(128, 128, 0)');

  static const LIGHT_GREEN  = const Color('rgb(130, 255, 90)');
  static const GREEN        = const Color('rgb(0, 128, 0)');
  static const DARK_GREEN   = const Color('rgb(0, 64, 0)');

  static const LIGHT_AQUA   = const Color('rgb(128, 255, 255)');
  static const AQUA         = const Color('rgb(0, 255, 255)');
  static const DARK_AQUA    = const Color('rgb(0, 128, 128)');

  static const LIGHT_BLUE   = const Color('rgb(128, 160, 255)');
  static const BLUE         = const Color('rgb(0, 64, 255)');
  static const DARK_BLUE    = const Color('rgb(0, 37, 168)');

  static const LIGHT_PURPLE = const Color('rgb(200, 140, 255)');
  static const PURPLE       = const Color('rgb(128, 0, 255)');
  static const DARK_PURPLE  = const Color('rgb(64, 0, 128)');

  static const LIGHT_BROWN  = const Color('rgb(190, 150, 100)');
  static const BROWN        = const Color('rgb(160, 110, 60)');
  static const DARK_BROWN   = const Color('rgb(100, 64, 32)');

  final String cssColor;

  const Color(this.cssColor);
}

class Glyph {
  /// The empty glyph: a clear glyph using the default background color
  /// [Color.BLACK].
  static const CLEAR = const Glyph.fromCharCode(CharCode.SPACE);

  final int char;
  final Color fore;
  final Color back;

  Glyph(String char, [Color fore, Color back])
      : char = char.codeUnits[0],
        fore = fore != null ? fore : Color.WHITE,
        back = back != null ? back : Color.BLACK;

  const Glyph.fromCharCode(this.char, [Color fore, Color back])
      : fore = fore != null ? fore : Color.WHITE,
        back = back != null ? back : Color.BLACK;

  factory Glyph.fromDynamic(charOrCharCode, [Color fore, Color back]) {
    if (charOrCharCode is String) return new Glyph(charOrCharCode, fore, back);
    return new Glyph.fromCharCode(charOrCharCode, fore, back);
  }

  operator ==(other) {
    if (other is! Glyph) return false;
    return char == other.char && fore == other.fore && back == other.back;
  }
}
