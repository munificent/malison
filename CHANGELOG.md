## 0.2.0

* Redo key input handling. Instead of a (mostly broken) `Keyboard` class, it
  exposes raw key down events as they happen and also allows user-defined
  key bindings.

* Refactor `UserInterface` and clean up how opaque/transparent screens are
  handled.
  
* Remove (useless) `write()` method.

* Handle semicolon keyCode difference between Firefox (59) and Chrome (186).
