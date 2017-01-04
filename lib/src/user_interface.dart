library malison.user_interface;

import 'dart:async';
import 'dart:html' as html;

import 'key_bindings.dart';
import 'terminal.dart';

/// A simple modal user interface layer.
///
/// It maintains a stack of screens. All screens in the stack update. Screens
/// may indicate if they are opaque or transparent. Transparent screens allow
/// the screen under them to render.
///
/// In addition, the interface can define a number of global [KeyBindings]
/// which screens can use to map raw keypresses to something higher-level.
class UserInterface<T> {
  /// Keyboard bindings for key press events.
  final keyPress = new KeyBindings<T>();

  final List<Screen<T>> _screens = [];
  RenderableTerminal _terminal;
  bool _dirty = true;

  StreamSubscription<html.KeyboardEvent> _keyDownSubscription;

  /// Whether or not the UI is listening for keyboard events.
  ///
  /// Initially off.
  bool get handlingInput => _keyDownSubscription != null;
  set handlingInput(bool value) {
    if (value == handlingInput) return;

    if (value) {
      _keyDownSubscription = html.document.body.onKeyDown.listen(_keyDown);
    } else {
      _keyDownSubscription.cancel();
      _keyDownSubscription = null;
    }
  }

  /// Whether or not the game loop is running and the UI is refreshing itself
  /// every frame.
  ///
  /// Initially off.
  ///
  /// If you want to manually refresh the UI yourself when you know it needs
  /// to be updated -- maybe your game is explicitly turn-based -- you can
  /// leave this off.
  bool get running => _running;
  bool _running = false;
  set running(bool value) {
    if (value == _running) return;

    _running = value;
    if (_running) {
      html.window.requestAnimationFrame(_tick);
    }
  }

  UserInterface([this._terminal]);

  void setTerminal(RenderableTerminal terminal) {
    _terminal = terminal;
    dirty();
  }

  /// Pushes [screen] onto the top of the stack.
  void push(Screen<T> screen) {
    screen._bind(this);
    _screens.add(screen);
    _render();
  }

  /// Pops the top screen off the top of the stack.
  ///
  /// The next screen down is activated. If [result] is given, it is passed to
  /// the new active screen's [activate] method.
  void pop([Object result]) {
    var screen = _screens.removeLast();
    screen._unbind();
    _screens[_screens.length - 1].activate(screen, result);
    _render();
  }

  /// Switches the current top screen to [screen].
  ///
  /// This is equivalent to a [pop] followed by a [push].
  void goTo(Screen<T> screen) {
    var old = _screens.removeLast();
    old._unbind();

    screen._bind(this);
    _screens.add(screen);
    _render();
  }

  void dirty() {
    _dirty = true;
  }

  void refresh() {
    for (var screen in _screens) screen.update();
    if (_dirty) _render();
  }

  void _keyDown(html.KeyboardEvent event) {
    var keyCode = event.keyCode;

    // Firefox uses 59 for semicolon.
    if (keyCode == 59) keyCode = KeyCode.semicolon;

    var input =
        keyPress.find(keyCode, shift: event.shiftKey, alt: event.altKey);

    var screen = _screens.last;
    if (input != null) {
      // Bound keys are always consumed, even if the screen doesn't use it.
      event.preventDefault();
      if (screen.handleInput(input)) return;
    }

    if (screen.keyDown(keyCode, shift: event.shiftKey, alt: event.altKey)) {
      event.preventDefault();
    }
  }

  /// Called every animation frame while the UI's game loop is running.
  void _tick(num time) {
    refresh();

    if (_running) html.window.requestAnimationFrame(_tick);
  }

  void _render() {
    // If the UI isn't currentl bound to a terminal, there's nothing to render.
    if (_terminal == null) return;

    _terminal.clear();

    // Skip past all of the covered screens.
    int i;
    for (i = _screens.length - 1; i >= 0; i--) {
      if (!_screens[i].isTransparent) break;
    }

    if (i < 0) i = 0;

    // Render the top opaque screen and any transparent ones above it.
    for (; i < _screens.length; i++) {
      _screens[i].render(_terminal);
    }

    _dirty = false;
    _terminal.render();
  }
}

class Screen<T> {
  UserInterface<T> _ui;

  /// The [UserInterface] this screen is bound to.
  UserInterface<T> get ui => _ui;

  /// Whether this screen allows any screens under it to be visible.
  ///
  /// Subclasses can override this. Defaults to `false`.
  bool get isTransparent => false;

  /// Binds this screen to [ui].
  void _bind(UserInterface<T> ui) {
    assert(_ui == null);
    _ui = ui;
  }

  /// Unbinds this screen from the [ui] that owns it.
  void _unbind() {
    assert(_ui != null);
    _ui = null;
  }

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
  bool handleInput(T input) => false;

  bool keyDown(int keyCode, {bool shift, bool alt}) => false;

  /// Called when the screen above this one ([popped]) has been popped and this
  /// screen is now the top-most screen. If a value was passed to [pop()], it
  /// will be passed to this as [result].
  void activate(Screen<T> popped, Object result) {}

  void update() {}
  void render(Terminal terminal) {}
}
