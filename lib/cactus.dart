part of snake;

class Cactus extends Scenery {
  static final ImageElement _cactus = new ImageElement(src: "images/cactus.png");

  Cactus(_game, _screen, _location, _size) :
    super(_game, _screen, _location, _size, _cactus) {
    _game.loadAsset(_image);
  }
}
