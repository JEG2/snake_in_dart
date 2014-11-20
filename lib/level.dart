part of snake;

class Level extends Screen {
  static const int  gridSize = 40;
  static const Size gridCell = const Size(gridSize, gridSize);

  static final ImageElement _background =
    new ImageElement(src: "images/sand.jpg");

  static final Random rng = new Random();

  bool      snakeAlive    = true;
  num       snakeVelocity = 2;  // must divide evenly into Level.gridSize
  SnakeHead snakeHead;

  Level(_game) : super(_game) {
    _game.loadAsset(_background);
    _addCacti();
    _addSnake();
    addBird();
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
    var tail    = new SnakeTail(
        _game,
        this,
        new Point(centerX - gridSize, centerY),
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
    snakeHead   = new SnakeHead(
        _game,
        this,
        new Point(centerX + gridSize, centerY),
        gridCell,
        0,
        q,
        tail
    );

    q[snakeHead.locationInGrid()] = 0;
    q[body.locationInGrid()]      = 0;
    q[tail.locationInGrid()]      = 0;

    addActor(snakeHead);
    addActor(body);
    addActor(tail);
  }

  void addBird() {
    var location;
    var i = 1;

    for (var x = 1; x < _game.width ~/ gridSize - 1; x++) {
      for (var y = 1; y < _game.height ~/ gridSize - 1; y++) {
        var gridLocation = new Point(x, y);
        var snakePresent = _actors.any( (actor) =>
            actor is SnakePart && actor.locationInGrid() == gridLocation
        );
        if (!snakePresent) {
          if (rng.nextDouble() < 1.0 / i) {
            location = new Point(x * gridSize, y * gridSize);
          }
          i++;
        }
      }
    }

    if (location != null) {
      snakeHead.bird = new Bird(_game, this, location, gridCell);
      addScenery(snakeHead.bird);
    }
  }

  void removeBirdAndReadd() {
    _scenery.removeLast();
    addBird();
  }
}
