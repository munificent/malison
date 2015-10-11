import 'dart:html' as html;
import 'dart:math' as math;

import 'package:malison/malison.dart';

const width = 80;
const height = 30;

final UserInterface ui = new UserInterface();

/// A few different terminals to choose from.
final terminals = [
  () => new RetroTerminal.dos(width, height),
  () => new RetroTerminal.shortDos(width, height),
  () => new CanvasTerminal(width, height,
      new Font('Menlo, Consolas', size: 12, w: 8, h: 14, x: 1, y: 11)),
  () => new CanvasTerminal(width, height,
      new Font('Courier', size: 13, w: 10, h: 15, x: 1, y: 11)),
  () => new CanvasTerminal(width, height,
      new Font('Courier', size: 12, w: 8, h: 14, x: 1, y: 10))
];

/// Index of the current terminal in [terminals].
int terminalIndex = 0;

main() {
  // Set up the keybindings.
  ui.keyPress.bind("next terminal", KeyCode.TAB);
  ui.keyPress.bind("prev terminal", KeyCode.TAB, shift: true);
  ui.keyPress.bind("animate", KeyCode.SPACE);

  updateTerminal();

  ui.push(new MainScreen());

  ui.handlingInput = true;
  ui.running = true;
}

updateTerminal() {
  html.document.body.children.clear();
  ui.setTerminal(terminals[terminalIndex]());
}

class MainScreen extends Screen {
  final List<Ball> balls = [];

  MainScreen() {
    var colors = [
      Color.RED, Color.ORANGE, Color.GOLD, Color.YELLOW,
      Color.GREEN, Color.AQUA, Color.BLUE, Color.PURPLE
    ];

    var random = new math.Random();

    for (var char in [CharCode.BULLET, CharCode.ASTERISK, "O".codeUnitAt(0)]) {
      for (var color in colors) {
        balls.add(new Ball(color, char,
            random.nextDouble() * Ball.pitWidth,
            random.nextDouble() * (Ball.pitHeight / 2.0),
            random.nextDouble() + 0.2,
            0.0));
      }
    }
  }

  bool handleInput(Object input) {
    switch (input) {
      case "next terminal":
        terminalIndex = (terminalIndex + 1) % terminals.length;
        updateTerminal();
        ui.refresh();
        break;

      case "prev terminal":
        terminalIndex = (terminalIndex - 1) % terminals.length;
        updateTerminal();
        ui.refresh();
        break;

      case "animate":
        ui.running = !ui.running;
        break;

      default:
        return false;
    }

    return true;
  }

  void update() {
    for (var ball in balls) {
      ball.update();
    }

    dirty();
  }

  void render(Terminal terminal) {
    terminal.clear();

    colorBar(int y, String name, Color light, Color medium, Color dark) {
      terminal.writeAt(2, y, name, Color.GRAY);
      terminal.writeAt(10, y, "light", light);
      terminal.writeAt(16, y, "medium", medium);
      terminal.writeAt(23, y, "dark", dark);

      terminal.writeAt(28, y, " light ", Color.BLACK, light);
      terminal.writeAt(35, y, " medium ", Color.BLACK, medium);
      terminal.writeAt(43, y, " dark ", Color.BLACK, dark);
    }

    terminal.writeAt(0, 0, "Predefined colors:");
    terminal.writeAt(59, 0, "switch terminal [tab]", Color.DARK_GRAY);
    terminal.writeAt(75, 0, "[tab]", Color.LIGHT_GRAY);
    colorBar(1, "gray", Color.LIGHT_GRAY, Color.GRAY, Color.DARK_GRAY);
    colorBar(2, "red", Color.LIGHT_RED, Color.RED, Color.DARK_RED);
    colorBar(3, "orange", Color.LIGHT_ORANGE, Color.ORANGE, Color.DARK_ORANGE);
    colorBar(4, "gold", Color.LIGHT_GOLD, Color.GOLD, Color.DARK_GOLD);
    colorBar(5, "yellow", Color.LIGHT_YELLOW, Color.YELLOW, Color.DARK_YELLOW);
    colorBar(6, "green", Color.LIGHT_GREEN, Color.GREEN, Color.DARK_GREEN);
    colorBar(7, "aqua", Color.LIGHT_AQUA, Color.AQUA, Color.DARK_AQUA);
    colorBar(8, "blue", Color.LIGHT_BLUE, Color.BLUE, Color.DARK_BLUE);
    colorBar(9, "purple", Color.LIGHT_PURPLE, Color.PURPLE, Color.DARK_PURPLE);
    colorBar(10, "brown", Color.LIGHT_BROWN, Color.BROWN, Color.DARK_BROWN);

    terminal.writeAt(0, 12, "Simple game loop for animation:");
    terminal.writeAt(66, 12, "toggle [space]", Color.DARK_GRAY);
    terminal.writeAt(73, 12, "[space]", Color.LIGHT_GRAY);

    for (var ball in balls) {
      ball.render(terminal);
    }
  }
}

class Ball {
  static const pitWidth = 78.0;
  static const pitHeight = 17.0;

  final Color color;
  final int charCode;

  double x, y, h, v;

  Ball(this.color, this.charCode, this.x, this.y, this.h, this.v);

  void update() {
    x += h;
    if (x < 0.0) {
      x = -x;
      h = -h;
    } else if (x > pitWidth) {
      x = pitWidth - x + pitWidth;
      h = -h;
    }

    v += 0.03;
    y += v;
    if (y > pitHeight) {
      y = pitHeight - y + pitHeight;
      v = -v;
    }
  }

  void render(Terminal terminal) {
    terminal.drawChar(2 + x.toInt(), 13 + y.toInt(), charCode, color);
  }
}