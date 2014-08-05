library malison.key_bindings;

import 'dart:html' as html;

class KeyBindings {
  /// The high-level inputs and the low level keyboard bindings that are mapped
  /// to them.
  final _bindings = new Map<_KeyBinding, Object>();

  void bind(Object input, int keyCode, {bool shift, bool alt}) {
    if (shift == null) shift = false;
    if (alt == null) alt = false;
    _bindings[new _KeyBinding(keyCode, shift: shift, alt: alt)] = input;
  }

  Object find(int keyCode, {bool shift, bool alt}) {
    if (shift == null) shift = false;
    if (alt == null) alt = false;
    return _bindings[new _KeyBinding(keyCode, shift: shift, alt: alt)];
  }
}

/// Defines a specific key input (character code and modifier keys) that can be
/// bound to a higher-level input in the application domain.
class _KeyBinding {
  /// The character code this is bound to.
  final int charCode;

  /// Whether this key binding requires the shift modifier key to be pressed.
  final bool shift;

  // TODO: Mac-specific. What should this be?
  /// Whether this key binding requires the alt modifier key to be pressed.
  final bool alt;

  _KeyBinding(this.charCode, {this.shift, this.alt});

  bool operator==(other) {
    if (other is! _KeyBinding) return false;
    return charCode == other.charCode &&
           shift == other.shift &&
           alt == other.alt;
  }

  int get hashCode => charCode.hashCode ^ shift.hashCode ^ alt.hashCode;

  String toString() {
    var result = "key($charCode";
    if (shift) result += " shift";
    if (alt) result += " alt";
    return result + ")";
  }
}

/// Raw key codes. These come straight from the DOM events.
class KeyCode {
  static const DELETE     = 8;
  static const TAB        = 9;
  static const ENTER      = 13;
  static const SHIFT      = 16;
  static const CONTROL    = 17;
  static const OPTION     = 18;
  static const ESCAPE     = 27;
  static const SPACE      = 32;

  static const LEFT       = 37;
  static const UP         = 38;
  static const RIGHT      = 39;
  static const DOWN       = 40;

  static const ZERO       = 48;
  static const ONE        = 49;
  static const TWO        = 50;
  static const THREE      = 51;
  static const FOUR       = 52;
  static const FIVE       = 53;
  static const SIX        = 54;
  static const SEVEN      = 55;
  static const EIGHT      = 56;
  static const NINE       = 57;

  static const A          = 65;
  static const B          = 66;
  static const C          = 67;
  static const D          = 68;
  static const E          = 69;
  static const F          = 70;
  static const G          = 71;
  static const H          = 72;
  static const I          = 73;
  static const J          = 74;
  static const K          = 75;
  static const L          = 76;
  static const M          = 77;
  static const N          = 78;
  static const O          = 79;
  static const P          = 80;
  static const Q          = 81;
  static const R          = 82;
  static const S          = 83;
  static const T          = 84;
  static const U          = 85;
  static const V          = 86;
  static const W          = 87;
  static const X          = 88;
  static const Y          = 89;
  static const Z          = 90;

  static const NUMPAD_0   = 96;
  static const NUMPAD_1   = 97;
  static const NUMPAD_2   = 98;
  static const NUMPAD_3   = 99;
  static const NUMPAD_4   = 100;
  static const NUMPAD_5   = 101;
  static const NUMPAD_6   = 102;
  static const NUMPAD_7   = 103;
  static const NUMPAD_8   = 104;
  static const NUMPAD_9   = 105;

  static const SEMICOLON  = 186;
  static const COMMA      = 188;
  static const PERIOD     = 190;
  static const SLASH      = 191;
  static const APOSTROPHE = 222;
}
