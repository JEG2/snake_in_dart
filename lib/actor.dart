part of snake;

abstract class Actor extends Scenery {
  num _angle;
  num _velocity;

  Actor(_game, _screen, _location, _size, _image, this._angle) :
    super(_game, _screen, _location, _size, _image);

  void update();
}
