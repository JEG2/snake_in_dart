part of snake;

class SnakeTail extends SnakePart {
  static final ImageElement _snake_tail =
    new ImageElement(src: "images/snake_tail.png");

  SnakeTail(_game, _screen, _location, _size, _angle, _q) :
    super(_game, _screen, _location, _size, _snake_tail, _angle, _q) {
    _game.loadAsset(_image);
  }

  // void update() {
  // }
}
