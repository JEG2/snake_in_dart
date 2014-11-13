part of snake;

class Level extends Screen {
  ImageElement _background = new ImageElement(src: "images/sand.jpg");

  Level(_game) : super(_game) {
    _game.loadAsset(_background);
  }

  void render(CanvasRenderingContext2D context, num frameDelta) {
    context.drawImageScaled(_background, 0, 0, _game.width, _game.height);
  }
}