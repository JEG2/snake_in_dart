part of snake;

abstract class Scenery {
  final Game   _game;
  final Screen _screen;

  Point        _location;
  Size         _size;
  ImageElement _image;

  Scenery(this._game, this._screen, this._location, this._size, this._image);

  void render(CanvasRenderingContext2D context, num frameDelta) {
    context.drawImageScaled(
        _image,
        _location.x,
        _location.y,
        _size.width,
        _size.height
    );
  }
}
