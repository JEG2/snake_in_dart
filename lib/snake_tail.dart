part of snake;

class SnakeTail extends SnakePart {
  static final ImageElement _snake_tail =
    new ImageElement(src: "images/snake_tail.png");

  int _bodiesToAdd     = 0;
  int _addingBodyDelay = 0;

  SnakeTail(_game, _screen, _location, _size, _angle, _q) :
    super(_game, _screen, _location, _size, _snake_tail, _angle, _q) {
    _game.loadAsset(_image);
  }

  void update() {
    if (_addingBodyDelay == 0) {
      super.update();

      if (_bodiesToAdd > 0) {
        _level.addActorLater(
            new SnakeBody(_game, _screen, _location, _size, _angle, _q)
        );
        _bodiesToAdd    -= 1;
        _addingBodyDelay = Level.gridSize ~/ _level.snakeVelocity;
      }
    } else {
      _addingBodyDelay -= 1;
    }
  }

  void addBody() {
    _bodiesToAdd += 1;
  }
}
