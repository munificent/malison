library malison.char_code;

/// Unicode code points for various special characters that also exist on
/// [code page 437][font].
///
/// [font]: http://en.wikipedia.org/wiki/Code_page_437
class CharCode {
  static const SPACE                        = 0x0020;
  static const ASTERISK                     = 0x002a;
  static const SOLID                        = 0x2588;
  static const HALF_LEFT                    = 0x258c;
  static const TRIPLE_BAR                   = 0x2261;
  static const PI                           = 0x03C0;

  // 1 - 15.
  static const WHITE_SMILING_FACE           = 0x263a;
  static const BLACK_SMILING_FACE           = 0x263b;
  static const BLACK_HEART_SUIT             = 0x2665;
  static const BLACK_DIAMOND_SUIT           = 0x2666;
  static const BLACK_CLUB_SUIT              = 0x2663;
  static const BLACK_SPADE_SUIT             = 0x2660;
  static const BULLET                       = 0x2022;
  static const INVERSE_BULLET = 0x25d8;
  static const WHITE_CIRCLE = 0x25cb;
  static const INVERSE_WHITE_CIRCLE = 0x25d9;
  static const MALE_SIGN = 0x2642;
  static const FEMALE_SIGN = 0x2640;
  static const EIGHTH_NOTE = 0x266a;
  static const BEAMED_EIGHTH_NOTES = 0x266b;
  static const WHITE_SUN_WITH_RAYS = 0x263c;

  // 16 - 31.
  static const BLACK_RIGHT_POINTING_POINTER = 0x25ba;
  static const BLACK_LEFT_POINTING_POINTER  = 0x25c4;
  static const UP_DOWN_ARROW = 0x2195;
  static const DOUBLE_EXCLAMATION_MARK = 0x203c;
  static const PILCROW = 0x00b6;
  static const SECTION_SIGN = 0x00a7;
  static const BLACK_RECTANGLE = 0x25ac;
  static const UP_DOWN_ARROW_WITH_BASE = 0x21a8;
  static const UPWARDS_ARROW = 0x2191;
  static const DOWNWARDS_ARROW = 0x2193;
  static const RIGHTWARDS_ARROW = 0x2192;
  static const LEFTWARDS_ARROW = 0x2190;
  static const RIGHT_ANGLE = 0x221f;
  static const LEFT_RIGHT_ARROW             = 0x2194;
  static const BLACK_UP_POINTING_TRIANGLE = 0x25b2;
  static const BLACK_DOWN_POINTING_TRIANGLE = 0x25bc;

  // 127.
  static const HOUSE = 0x2302;

  // 128 - 143.
  static const LATIN_CAPITAL_LETTER_C_WITH_CEDILLA = 0x00c7;
  static const LATIN_SMALL_LETTER_U_WITH_DIAERESIS = 0x00fc;
  static const LATIN_SMALL_LETTER_E_WITH_ACUTE = 0x00e9;
  static const LATIN_SMALL_LETTER_A_WITH_CIRCUMFLEX = 0x00e2;
  static const LATIN_SMALL_LETTER_A_WITH_DIAERESIS = 0x00e4;
  static const LATIN_SMALL_LETTER_A_WITH_GRAVE = 0x00e0;
  static const LATIN_SMALL_LETTER_A_WITH_RING_ABOVE = 0x00e5;
  static const LATIN_SMALL_LETTER_C_WITH_CEDILLA = 0x00e7;
  static const LATIN_SMALL_LETTER_E_WITH_CIRCUMFLEX = 0x00ea;
  static const LATIN_SMALL_LETTER_E_WITH_DIAERESIS = 0x00eb;
  static const LATIN_SMALL_LETTER_E_WITH_GRAVE = 0x00e8;
  static const LATIN_SMALL_LETTER_I_WITH_DIAERESIS = 0x00ef;
  static const LATIN_SMALL_LETTER_I_WITH_CIRCUMFLEX = 0x00ee;
  static const LATIN_SMALL_LETTER_I_WITH_GRAVE = 0x00ec;
  static const LATIN_CAPITAL_LETTER_A_WITH_DIAERESIS = 0x00c4;
  static const LATIN_CAPITAL_LETTER_A_WITH_RING_ABOVE = 0x00c5;

  // 144 - 159.
  static const LATIN_CAPITAL_LETTER_E_WITH_ACUTE = 0x00c9;
  static const LATIN_SMALL_LETTER_AE = 0x00e6;
  static const LATIN_CAPITAL_LETTER_AE = 0x00c6;
  static const LATIN_SMALL_LETTER_O_WITH_CIRCUMFLEX = 0x00f4;
  static const LATIN_SMALL_LETTER_O_WITH_DIAERESIS = 0x00f6;
  static const LATIN_SMALL_LETTER_O_WITH_GRAVE = 0x00f2;
  static const LATIN_SMALL_LETTER_U_WITH_CIRCUMFLEX = 0x00fb;
  static const LATIN_SMALL_LETTER_U_WITH_GRAVE = 0x00f9;
  static const LATIN_SMALL_LETTER_Y_WITH_DIAERESIS = 0x00ff;
  static const LATIN_CAPITAL_LETTER_O_WITH_DIAERESIS = 0x00d6;
  static const LATIN_CAPITAL_LETTER_U_WITH_DIAERESIS = 0x00dc;
  static const CENT_SIGN = 0x00a2;
  static const POUND_SIGN = 0x00a3;
  static const YEN_SIGN = 0x00a5;
  static const PESETA_SIGN = 0x20a7;
  static const LATIN_SMALL_LETTER_F_WITH_HOOK = 0x0192;

  // 160 - 175.
  static const LATIN_SMALL_LETTER_A_WITH_ACUTE = 0x00e1;
  static const LATIN_SMALL_LETTER_I_WITH_ACUTE = 0x00ed;
  static const LATIN_SMALL_LETTER_O_WITH_ACUTE = 0x00f3;
  static const LATIN_SMALL_LETTER_U_WITH_ACUTE = 0x00fa;
  static const LATIN_SMALL_LETTER_N_WITH_TILDE = 0x00f1;
  static const LATIN_CAPITAL_LETTER_N_WITH_TILDE = 0x00d1;
  static const FEMININE_ORDINAL_INDICATOR = 0x00aa;
  static const MASCULINE_ORDINAL_INDICATOR = 0x00ba;
  static const INVERTED_QUESTION_MARK = 0x00bf;
  static const REVERSED_NOT_SIGN = 0x2310;
  static const NOT_SIGN = 0x00ac;
  static const VULGAR_FRACTION_ONE_HALF = 0x00bd;
  static const VULGAR_FRACTION_ONE_QUARTER = 0x00bc;
  static const INVERTED_EXCLAMATION_MARK = 0x00a1;
  static const LEFT_POINTING_DOUBLE_ANGLE_QUOTATION_MARK = 0x00ab;
  static const RIGHT_POINTING_DOUBLE_ANGLE_QUOTATION_MARK = 0x00bb;

  // 176 - 191.
  static const LIGHT_SHADE = 0x2591;
  static const MEDIUM_SHADE = 0x2592;
  static const DARK_SHADE = 0x2593;
  static const BOX_DRAWINGS_LIGHT_VERTICAL = 0x2502;
  static const BOX_DRAWINGS_LIGHT_VERTICAL_AND_LEFT = 0x2524;
  static const BOX_DRAWINGS_VERTICAL_SINGLE_AND_LEFT_DOUBLE = 0x2561;
  static const BOX_DRAWINGS_VERTICAL_DOUBLE_AND_LEFT_SINGLE = 0x2562;
  static const BOX_DRAWINGS_DOWN_DOUBLE_AND_LEFT_SINGLE = 0x2556;
  static const BOX_DRAWINGS_DOWN_SINGLE_AND_LEFT_DOUBLE = 0x2555;
  static const BOX_DRAWINGS_DOUBLE_VERTICAL_AND_LEFT = 0x2563;
  static const BOX_DRAWINGS_DOUBLE_VERTICAL = 0x2551;
  static const BOX_DRAWINGS_DOUBLE_DOWN_AND_LEFT = 0x2557;
  static const BOX_DRAWINGS_DOUBLE_UP_AND_LEFT = 0x255d;
  static const BOX_DRAWINGS_UP_DOUBLE_AND_LEFT_SINGLE = 0x255c;
  static const BOX_DRAWINGS_UP_SINGLE_AND_LEFT_DOUBLE = 0x255b;
  static const BOX_DRAWINGS_LIGHT_DOWN_AND_LEFT = 0x2510;

  // 192 - 207.
  static const BOX_DRAWINGS_LIGHT_UP_AND_RIGHT = 0x2514;
  static const BOX_DRAWINGS_LIGHT_UP_AND_HORIZONTAL = 0x2534;
  static const BOX_DRAWINGS_LIGHT_DOWN_AND_HORIZONTAL = 0x252c;
  static const BOX_DRAWINGS_LIGHT_VERTICAL_AND_RIGHT = 0x251c;
  static const BOX_DRAWINGS_LIGHT_HORIZONTAL = 0x2500;
  static const BOX_DRAWINGS_LIGHT_VERTICAL_AND_HORIZONTAL = 0x253c;
  static const BOX_DRAWINGS_VERTICAL_SINGLE_AND_RIGHT_DOUBLE = 0x255e;
  static const BOX_DRAWINGS_VERTICAL_DOUBLE_AND_RIGHT_SINGLE = 0x255f;
  static const BOX_DRAWINGS_DOUBLE_UP_AND_RIGHT = 0x255a;
  static const BOX_DRAWINGS_DOUBLE_DOWN_AND_RIGHT = 0x2554;
  static const BOX_DRAWINGS_DOUBLE_UP_AND_HORIZONTAL = 0x2569;
  static const BOX_DRAWINGS_DOUBLE_DOWN_AND_HORIZONTAL = 0x2566;
  static const BOX_DRAWINGS_DOUBLE_VERTICAL_AND_RIGHT = 0x2560;
  static const BOX_DRAWINGS_DOUBLE_HORIZONTAL = 0x2550;
  static const BOX_DRAWINGS_DOUBLE_VERTICAL_AND_HORIZONTAL = 0x256c;
  static const BOX_DRAWINGS_UP_SINGLE_AND_HORIZONTAL_DOUBLE = 0x2567;

  // 208 - 223.
  static const BOX_DRAWINGS_UP_DOUBLE_AND_HORIZONTAL_SINGLE = 0x2568;
  static const BOX_DRAWINGS_DOWN_SINGLE_AND_HORIZONTAL_DOUBLE = 0x2564;
  static const BOX_DRAWINGS_DOWN_DOUBLE_AND_HORIZONTAL_SINGLE = 0x2565;
  static const BOX_DRAWINGS_UP_DOUBLE_AND_RIGHT_SINGLE = 0x2559;
  static const BOX_DRAWINGS_UP_SINGLE_AND_RIGHT_DOUBLE = 0x2558;
  static const BOX_DRAWINGS_DOWN_SINGLE_AND_RIGHT_DOUBLE = 0x2552;
  static const BOX_DRAWINGS_DOWN_DOUBLE_AND_RIGHT_SINGLE = 0x2553;
  static const BOX_DRAWINGS_VERTICAL_DOUBLE_AND_HORIZONTAL_SINGLE = 0x256b;
  static const BOX_DRAWINGS_VERTICAL_SINGLE_AND_HORIZONTAL_DOUBLE = 0x256a;
  static const BOX_DRAWINGS_LIGHT_UP_AND_LEFT = 0x2518;
  static const BOX_DRAWINGS_LIGHT_DOWN_AND_RIGHT = 0x250c;
  static const FULL_BLOCK = 0x2588;
  static const LOWER_HALF_BLOCK = 0x2584;
  static const LEFT_HALF_BLOCK = 0x258c;
  static const RIGHT_HALF_BLOCK = 0x2590;
  static const UPPER_HALF_BLOCK = 0x2580;

  // 224 - 239.
  static const GREEK_SMALL_LETTER_ALPHA = 0x03b1;
  static const LATIN_SMALL_LETTER_SHARP_S = 0x00df;
  static const GREEK_CAPITAL_LETTER_GAMMA = 0x0393;
  static const GREEK_SMALL_LETTER_PI = 0x03c0;
  static const GREEK_CAPITAL_LETTER_SIGMA = 0x03a3;
  static const GREEK_SMALL_LETTER_SIGMA = 0x03c3;
  static const MICRO_SIGN = 0x00b5;
  static const GREEK_SMALL_LETTER_TAU = 0x03c4;
  static const GREEK_CAPITAL_LETTER_PHI = 0x03a6;
  static const GREEK_CAPITAL_LETTER_THETA = 0x0398;
  static const GREEK_CAPITAL_LETTER_OMEGA = 0x03a9;
  static const GREEK_SMALL_LETTER_DELTA = 0x03b4;
  static const INFINITY = 0x221e;
  static const GREEK_SMALL_LETTER_PHI = 0x03c6;
  static const GREEK_SMALL_LETTER_EPSILON = 0x03b5;
  static const INTERSECTION = 0x2229;

  // 240 - 254.
  static const IDENTICAL_TO = 0x2261;
  static const PLUS_MINUS_SIGN = 0x00b1;
  static const GREATER_THAN_OR_EQUAL_TO = 0x2265;
  static const LESS_THAN_OR_EQUAL_TO = 0x2264;
  static const TOP_HALF_INTEGRAL = 0x2320;
  static const BOTTOM_HALF_INTEGRAL = 0x2321;
  static const DIVISION_SIGN = 0x00f7;
  static const ALMOST_EQUAL_TO = 0x2248;
  static const DEGREE_SIGN = 0x00b0;
  static const BULLET_OPERATOR = 0x2219;
  static const MIDDLE_DOT = 0x00b7;
  static const SQUARE_ROOT = 0x221a;
  static const SUPERSCRIPT_LATIN_SMALL_LETTER_N = 0x207f;
  static const SUPERSCRIPT_TWO = 0x00b2;
  static const BLACK_SQUARE = 0x25a0;
}
