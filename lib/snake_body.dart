part of snake;

class SnakeBody extends SnakePart {
  static final ImageElement _snake_body =
    new ImageElement(src: "images/snake_body.png");

  SnakeBody(_game, _screen, _location, _size, _angle, _q) :
    super(_game, _screen, _location, _size, _snake_body, _angle, _q) {
    if (_game.isLoading) {
      _game.loadAsset(_image);
    }
  }
}
