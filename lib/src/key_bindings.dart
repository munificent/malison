class KeyBindings<T> {
  /// The high-level inputs and the low level keyboard bindings that are mapped
  /// to them.
  final _bindings = <_KeyBinding, T>{};

  void bind(T input, int keyCode, {bool shift = false, bool alt = false}) {
    _bindings[_KeyBinding(keyCode, shift: shift, alt: alt)] = input;
  }

  T? find(int keyCode, {bool shift = false, bool alt = false}) {
    return _bindings[_KeyBinding(keyCode, shift: shift, alt: alt)];
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

  _KeyBinding(this.charCode, {required this.shift, required this.alt});

  @override
  bool operator ==(Object other) {
    return other is _KeyBinding &&
        charCode == other.charCode &&
        shift == other.shift &&
        alt == other.alt;
  }

  @override
  int get hashCode => charCode.hashCode ^ shift.hashCode ^ alt.hashCode;

  @override
  String toString() {
    var result = "key($charCode";
    if (shift) result += " shift";
    if (alt) result += " alt";
    return "$result)";
  }
}

/// Raw key codes. These come straight from the DOM events.
class KeyCode {
  static const delete = 8;
  static const tab = 9;
  static const enter = 13;
  static const shift = 16;
  static const control = 17;
  static const option = 18;
  static const escape = 27;
  static const space = 32;

  static const left = 37;
  static const up = 38;
  static const right = 39;
  static const down = 40;

  static const zero = 48;
  static const one = 49;
  static const two = 50;
  static const three = 51;
  static const four = 52;
  static const five = 53;
  static const six = 54;
  static const seven = 55;
  static const eight = 56;
  static const nine = 57;

  static const a = 65;
  static const b = 66;
  static const c = 67;
  static const d = 68;
  static const e = 69;
  static const f = 70;
  static const g = 71;
  static const h = 72;
  static const i = 73;
  static const j = 74;
  static const k = 75;
  static const l = 76;
  static const m = 77;
  static const n = 78;
  static const o = 79;
  static const p = 80;
  static const q = 81;
  static const r = 82;
  static const s = 83;
  static const t = 84;
  static const u = 85;
  static const v = 86;
  static const w = 87;
  static const x = 88;
  static const y = 89;
  static const z = 90;

  static const numpad0 = 96;
  static const numpad1 = 97;
  static const numpad2 = 98;
  static const numpad3 = 99;
  static const numpad4 = 100;
  static const numpad5 = 101;
  static const numpad6 = 102;
  static const numpad7 = 103;
  static const numpad8 = 104;
  static const numpad9 = 105;
  static const numpadClear = 12;
  static const numpadMultiply = 106;
  static const numpadAdd = 107;
  static const numpadSubtract = 109;
  static const numpadDecimal = 110;
  static const numpadDivide = 111;
  static const numpadEquals = 1000;
  static const numpadEnter = 1001;

  static const semicolon = 186;
  static const equals = 187;
  static const comma = 188;
  static const hyphen = 189;
  static const period = 190;
  static const slash = 191;
  static const backtick = 192;
  static const leftBracket = 219;
  static const backslash = 220;
  static const rightBracket = 221;
  static const apostrophe = 222;
}
