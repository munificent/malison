Malison is a small [Dart][] library for drawing old school ASCII terminals in
the browser. I harvested it from my roguelike game, [Hauberk][] and it's aimed
primarily at web games ASCII graphics. Think of it like curses for the web.

[dart]: https://www.dartlang.org/
[hauberk]: https://github.com/munificent/hauberk

## Using it

Add it to your package's pubspec:

```yaml
dependencies:
  malison: any
```

Then use the library:

```dart
import 'dart:html';

import 'package:malison/malison.dart';

void main() {
  // Create or query a <canvas> element to bind it to.
  var canvas = new CanvasElement();
  document.body.children.add(canvas);

  // Create a new terminal. CanvasTerminal uses your browser's fonts.
  // RetroTerminal uses a built in DOS-style Code Page 437 font.
  var terminal = new RetroTerminal.dos(80, 40, canvas);

  // You can draw strings at given positions.
  terminal.writeAt(0, 0, "This is a terminal!");

  // You can control the foreground and background color.
  terminal.writeAt(0, 1, "This is blue on green", Color.BLUE, Color.GREEN);

  // You can also draw individual glyphs -- character+color units.
  terminal.drawGlyph(3, 4, new Glyph.fromCharCode(CharCode.BLACK_HEART_SUIT,
      Color.RED, Color.WHITE));

  // When you're done drawing, tell it to render all of the changes. It renders
  // in batches for performance.
  terminal.render();
}
```
