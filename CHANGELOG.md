## 0.7.0

* Fill in the rest of the character codes to `CharCode`.
* Add `Color.blend()` and store colors as RGB.

## 0.6.0

* Split into two libraries. The core malison library does not import "dart:html"
  and can be used in command-line applications. It's not *useful* outside of
  the web, but it lets you test code in a "headless" fashion that uses malison
  on the standalone VM.

## 0.5.1

* Get rid of implicit casts and dynamic.

## 0.5.0

* Add type parameters to `UserInterface`, `KeyBindings`, and
  `Screen` so that the bound objects can be precisely typed.

## 0.4.3

* Make strong mode clean.

## 0.4.2

* Widen constraint on piecemeal.

## 0.4.1

* Fix semicolon handling on Firefox.

## 0.4.0

* Add constants to `CharCode` for every character in code page 437.
* Make constants `lowerCamelCase`.

## 0.3.0

* Automatically create a canvas if not given one.
* Allow creating a `UserInterface` without an initial terminal.
* Add an example app.

## 0.2.1

* Fix bad assert in `Screen._bind()`.

## 0.2.0

* Redo key input handling. Instead of a (mostly broken) `Keyboard` class, it
  exposes raw key down events as they happen and also allows user-defined
  key bindings.

* Refactor `UserInterface` and clean up how opaque/transparent screens are
  handled.

* Remove (useless) `write()` method.

* Handle semicolon keyCode difference between Firefox (59) and Chrome (186).
