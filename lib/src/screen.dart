library malison.screen;

import 'dart:html' as html;

import 'key_bindings.dart';
import 'terminal.dart';

class Screen {
  UserInterface _ui;

  /// The [UserInterface] this screen is bound to.
  UserInterface get ui => _ui;

  /// Binds this screen to [ui].
  void _bind(UserInterface ui) {
    assert(ui == null);
    _ui = ui;
  }

  /// Unbinds this screen from the [ui] that owns it.
  void _unbind() {
    assert(_ui != null);
    _ui = null;
  }

  /// Gets whether this screen is the active (top-most) screen in the screen
  /// stack.
  bool get isTopScreen => _ui.isTopScreen(this);

  /// Marks the user interface as needing to be rendered.
  ///
  /// Call this during [update] to indicate that a subsequent call to [render]
  /// is needed.
  void dirty() {
    // If we aren't bound (yet), just do nothing. The screen will be dirtied
    // when it gets bound.
    if (_ui == null) return;

    _ui.dirty();
  }

  /// If a keypress has a binding defined for it and is pressed, this will be
  /// called with the bound input when this screen is active.
  ///
  /// If this returns `false` (the default), then the lower-level [keyDown]
  /// method will be called.
  bool handleInput(Object input) => false;

  bool keyDown(int keyCode, {bool shift, bool alt}) => false;

  /// Called when the screen above this one ([popped]) has been popped and this
  /// screen is now the top-most screen. If a value was passed to [pop()], it
  /// will be passed to this as [result].
  void activate(Screen popped, result) {}

  void update() {}
  void render(Terminal terminal) {}
}

class UserInterface {
  final keyBindings = new KeyBindings();
  final List<Screen>  _screens;
  RenderableTerminal _terminal;
  bool _dirty;

  UserInterface(this._terminal)
  : _screens = <Screen>[] {
    html.document.body.onKeyDown.listen(_keyDown);
  }

  void setTerminal(RenderableTerminal terminal) {
    _terminal = terminal;
    dirty();
  }

  void push(Screen screen) {
    screen._bind(this);
    _screens.add(screen);
    _render();
  }

  void pop([result]) {
    var screen = _screens.removeLast();
    screen._unbind();
    _screens[_screens.length - 1].activate(screen, result);
    _render();
  }

  void goTo(Screen screen) {
    var old = _screens.removeLast();
    old._unbind();

    screen._bind(this);
    _screens.add(screen);
    _render();
  }

  void dirty() { _dirty = true; }

  bool isTopScreen(Screen screen) => _screens.last == screen;

  void tick() {
    for (var screen in _screens) screen.update();

    if (_dirty) _render();
  }

  void _keyDown(html.KeyEvent event) {
    var screen = _screens.last;

    var input = keyBindings.find(event.keyCode, shift: event.shiftKey,
        alt: event.altKey);

    if (input != null) {
      // Bound keys are always consumed, even if the screen doesn't use it.
      event.preventDefault();
      if (screen.handleInput(input)) return;
    }

    if (screen.keyDown(event.keyCode, shift: event.shiftKey,
        alt: event.altKey)) {
      event.preventDefault();
    }
  }

  void _render() {
    for (var screen in _screens) screen.render(_terminal);

    _dirty = false;
    _terminal.render();
  }
}
