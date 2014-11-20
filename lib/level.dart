part of snake;

class Level extends Screen {
  static const int  gridSize = 40;
  static const Size gridCell = const Size(gridSize, gridSize);

  static final ImageElement _background =
    new ImageElement(src: "images/sand.jpg");

  bool snakeAlive    = true;
  num  snakeVelocity = 2;  // must divide evenly into Level.gridSize

  Level(_game) : super(_game) {
    _game.loadAsset(_background);
    _addCacti();
    _addSnake();
  }

  void update() {
    if (snakeAlive) {
      super.update();
    }
  }

  void render(CanvasRenderingContext2D context, num frameDelta) {
    context.drawImageScaled(_background, 0, 0, _game.width, _game.height);
    super.render(context, frameDelta);
  }

  void _addCacti() {
    for (var x = 0; x < _game.width; x += gridSize) {
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(x, 0),
              gridCell
          )
      );
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(x, _game.height - gridSize),
              gridCell
          )
      );
    }
    for (var y = gridSize; y < _game.height - gridSize; y += gridSize) {
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(0, y),
              gridCell
          )
      );
      addScenery(
          new Cactus(
              _game,
              this,
              new Point(_game.width - gridSize, y),
              gridCell
          )
      );
    }
  }

  void _addSnake() {
    var centerX = _game.width  / gridSize ~/ 2 * gridSize;
    var centerY = _game.height / gridSize ~/ 2 * gridSize;
    var q       = new Map<Point, int>();
    var head    = new SnakeHead(
        _game,
        this,
        new Point(centerX + gridSize, centerY),
        gridCell,
        0,
        q
    );
    var body    = new SnakeBody(
        _game,
        this,
        new Point(centerX, centerY),
        gridCell,
        0,
        q
    );
    var tail    = new SnakeTail(
        _game,
        this,
        new Point(centerX - gridSize, centerY),
        gridCell,
        0,
        q
    );

    q[head.locationInGrid()] = 0;
    q[body.locationInGrid()] = 0;
    q[tail.locationInGrid()] = 0;

    addActor(head);
    addActor(body);
    addActor(tail);
  }
}
