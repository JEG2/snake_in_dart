part of snake;

class Level extends Screen {
  static const int GRID_SIZE = 40;

  static final ImageElement _background =
    new ImageElement(src: "images/sand.jpg");

  Level(_game) : super(_game) {
    _game.loadAsset(_background);
    _addCacti();
  }

  void render(CanvasRenderingContext2D context, num frameDelta) {
    context.drawImageScaled(_background, 0, 0, _game.width, _game.height);
    super.render(context, frameDelta);
  }

  void _addCacti() {
    for (var x = 0; x < _game.width; x += GRID_SIZE) {
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(x, 0),
              new Size(GRID_SIZE, GRID_SIZE)
          )
      );
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(x, _game.height - GRID_SIZE),
              new Size(GRID_SIZE, GRID_SIZE)
          )
      );
    }
    for (var y = GRID_SIZE; y < _game.height - GRID_SIZE; y += GRID_SIZE) {
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(0, y),
              new Size(GRID_SIZE, GRID_SIZE)
          )
      );
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(_game.width - GRID_SIZE, y),
              new Size(GRID_SIZE, GRID_SIZE)
          )
      );
    }
  }
}