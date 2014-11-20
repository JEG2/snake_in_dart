part of snake;

class Bird extends Scenery {
  static final ImageElement _bird = new ImageElement(src: "images/bird.png");

  Bird(_game, _screen, _location, _size) :
    super(_game, _screen, _location, _size, _bird) {
    _game.loadAsset(_image);
  }
}
