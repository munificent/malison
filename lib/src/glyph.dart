import 'char_code.dart';

class Color {
  static const black       = const Color(0, 0, 0);
  static const white       = const Color(255, 255, 255);

  static const lightGray   = const Color(192, 192, 192);
  static const gray        = const Color(128, 128, 128);
  static const darkGray    = const Color(64, 64, 64);

  static const lightRed    = const Color(255, 160, 160);
  static const red         = const Color(220, 0, 0);
  static const darkRed     = const Color(100, 0, 0);

  static const lightOrange = const Color(255, 200, 170);
  static const orange      = const Color(255, 128, 0);
  static const darkOrange  = const Color(128, 64, 0);

  static const lightGold   = const Color(255, 230, 150);
  static const gold        = const Color(255, 192, 0);
  static const darkGold    = const Color(128, 96, 0);

  static const lightYellow = const Color(255, 255, 150);
  static const yellow      = const Color(255, 255, 0);
  static const darkYellow  = const Color(128, 128, 0);

  static const lightGreen  = const Color(130, 255, 90);
  static const green       = const Color(0, 128, 0);
  static const darkGreen   = const Color(0, 64, 0);

  static const lightAqua   = const Color(128, 255, 255);
  static const aqua        = const Color(0, 255, 255);
  static const darkAqua    = const Color(0, 128, 128);

  static const lightBlue   = const Color(128, 160, 255);
  static const blue        = const Color(0, 64, 255);
  static const darkBlue    = const Color(0, 37, 168);

  static const lightPurple = const Color(200, 140, 255);
  static const purple      = const Color(128, 0, 255);
  static const darkPurple  = const Color(64, 0, 128);

  static const lightBrown  = const Color(190, 150, 100);
  static const brown       = const Color(160, 110, 60);
  static const darkBrown   = const Color(100, 64, 32);

  final int r;
  final int g;
  final int b;

  String get cssColor => "rgb($r, $g, $b)";

  const Color(this.r, this.g, this.b);

  int get hashCode => r.hashCode ^ g.hashCode ^ b.hashCode;

  bool operator ==(Object other) {
    if (other is Color) {
      return r == other.r && g == other.g && b == other.b;
    }

    return false;
  }

  Color blend(Color other, int percentOther) {
    var fractionOther = percentOther / 100;
    var fractionThis = 1.0 - fractionOther;
    return new Color(
        (r * fractionThis + other.r * fractionOther).toInt(),
        (g * fractionThis + other.g * fractionOther).toInt(),
        (b * fractionThis + other.b * fractionOther).toInt());
  }
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

  factory Glyph.fromDynamic(Object charOrCharCode, [Color fore, Color back]) {
    if (charOrCharCode is String) return new Glyph(charOrCharCode, fore, back);
    return new Glyph.fromCharCode(charOrCharCode as int, fore, back);
  }

  int get hashCode => char.hashCode ^ fore.hashCode ^ back.hashCode;

  operator ==(Object other) {
    if (other is Glyph) {
      return char == other.char && fore == other.fore && back == other.back;
    }

    return false;
  }
}
