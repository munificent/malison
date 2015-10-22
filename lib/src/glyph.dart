library malison.glyph;

import 'char_code.dart';

class Color {
  static const black       = const Color('#000');
  static const white       = const Color('#fff');

  static const lightGray   = const Color('rgb(192, 192, 192)');
  static const gray        = const Color('rgb(128, 128, 128)');
  static const darkGray    = const Color('rgb(64, 64, 64)');

  static const lightRed    = const Color('rgb(255, 160, 160)');
  static const red         = const Color('rgb(220, 0, 0)');
  static const darkRed     = const Color('rgb(100, 0, 0)');

  static const lightOrange = const Color('rgb(255, 200, 170)');
  static const orange      = const Color('rgb(255, 128, 0)');
  static const darkOrange  = const Color('rgb(128, 64, 0)');

  static const lightGold   = const Color('rgb(255, 230, 150)');
  static const gold        = const Color('rgb(255, 192, 0)');
  static const darkGold    = const Color('rgb(128, 96, 0)');

  static const lightYellow = const Color('rgb(255, 255, 150)');
  static const yellow      = const Color('rgb(255, 255, 0)');
  static const darkYellow  = const Color('rgb(128, 128, 0)');

  static const lightGreen  = const Color('rgb(130, 255, 90)');
  static const green       = const Color('rgb(0, 128, 0)');
  static const darkGreen   = const Color('rgb(0, 64, 0)');

  static const lightAqua   = const Color('rgb(128, 255, 255)');
  static const aqua        = const Color('rgb(0, 255, 255)');
  static const darkAqua    = const Color('rgb(0, 128, 128)');

  static const lightBlue   = const Color('rgb(128, 160, 255)');
  static const blue        = const Color('rgb(0, 64, 255)');
  static const darkBlue    = const Color('rgb(0, 37, 168)');

  static const lightPurple = const Color('rgb(200, 140, 255)');
  static const purple      = const Color('rgb(128, 0, 255)');
  static const darkPurple  = const Color('rgb(64, 0, 128)');

  static const lightBrown  = const Color('rgb(190, 150, 100)');
  static const brown       = const Color('rgb(160, 110, 60)');
  static const darkBrown   = const Color('rgb(100, 64, 32)');

  final String cssColor;

  const Color(this.cssColor);
}

class Glyph {
  /// The empty glyph: a clear glyph using the default background color
  /// [Color.BLACK].
  static const clear = const Glyph.fromCharCode(CharCode.space);

  final int char;
  final Color fore;
  final Color back;

  Glyph(String char, [Color fore, Color back])
      : char = char.codeUnits[0],
        fore = fore != null ? fore : Color.white,
        back = back != null ? back : Color.black;

  const Glyph.fromCharCode(this.char, [Color fore, Color back])
      : fore = fore != null ? fore : Color.white,
        back = back != null ? back : Color.black;

  factory Glyph.fromDynamic(charOrCharCode, [Color fore, Color back]) {
    if (charOrCharCode is String) return new Glyph(charOrCharCode, fore, back);
    return new Glyph.fromCharCode(charOrCharCode, fore, back);
  }

  operator ==(other) {
    if (other is! Glyph) return false;
    return char == other.char && fore == other.fore && back == other.back;
  }
}
