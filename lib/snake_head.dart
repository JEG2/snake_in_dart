part of snake;

class SnakeHead extends SnakePart {
  static const Map<int, int> keys = const {37: 180, 38: 270, 39: 0, 40: 90};

  static final ImageElement _snake_head =
    new ImageElement(src: "images/snake_head.png");
  static final ImageElement _dead = new ImageElement(src: "images/dead.png");

  final DoubleLinkedQueue<int> _inputs = new DoubleLinkedQueue<int>();

  int       _previousAngle = 0;
  Point     _previousGridLocation;
  Bird      bird;
  SnakeTail _tail;

  SnakeHead(_game, _screen, _location, _size, _angle, _q, this._tail) :
    super(_game, _screen, _location, _size, _snake_head, _angle, _q) {
    _previousGridLocation = locationInGrid();

    _game.loadAsset(_image);
    _game.loadAsset(_dead);
    _processInput();
  }

  void update() {
    super.update();

    var currentLocation = locationInGrid();
    _handleDeath(currentLocation);
    _eatBirds(currentLocation);
    _makeTurns();
    _updateMoveQ(currentLocation);
  }

  void _processInput() {
    window.onKeyDown.listen( (event) {
      var newAngle = keys[event.keyCode];
      if (newAngle != null) {
        _inputs.addLast(newAngle);
      }
    } );
  }

  void _handleDeath(Point currentLocation) {
    currentLocation = _alignInGrid(currentLocation);
    _screen._scenery.forEach( (scenery) {
      if ( scenery is Cactus &&
           currentLocation == locationInGrid(scenery._location) ) {
        _die();
      }
    } );
    _screen._actors.skip(1).forEach( (actor) {
      if (currentLocation == locationInGrid(actor._location)) {
        _die();
      }
    } );
  }

  void _eatBirds(Point currentLocation) {
    currentLocation = _alignInGrid(currentLocation);
    if (locationInGrid(bird._location) == currentLocation) {
      bird == null;
      _level.removeBirdAndReadd();
      _tail.addBody();
    }
  }

  void _makeTurns() {
    if (!_alignedWithGrid()) return;

    _previousAngle = _angle;

    if (_inputs.isEmpty) return;

    if (_angle == 0 && (_inputs.first == 270 || _inputs.first == 90)) {
      _turnTo(_inputs.removeFirst());
    } else if (_angle == 90 && (_inputs.first == 0 || _inputs.first == 180)) {
      _turnTo(_inputs.removeFirst());
    } else if (_angle == 180 && (_inputs.first == 90 || _inputs.first == 270)) {
      _turnTo(_inputs.removeFirst());
    } else if (_angle == 270 && (_inputs.first == 180 || _inputs.first == 0)) {
      _turnTo(_inputs.removeFirst());
    } else {
      _inputs.clear();
    }
  }

  void _updateMoveQ(Point currentLocation) {
    if (_previousGridLocation != currentLocation && _alignedWithGrid()) {
      _q[currentLocation]   = _angle;
      _previousGridLocation = currentLocation;
    }
  }

  Point _alignInGrid(Point currentLocation) {
    if (_angle == 0 && _location.x % Level.gridSize != 0) {
      return new Point(currentLocation.x + 1, currentLocation.y);
    } else if (_angle == 90 && _location.y % Level.gridSize != 0) {
      return new Point(currentLocation.x, currentLocation.y + 1);
    } else {
      return currentLocation;
    }
  }

  void _die() {
    _image            = _dead;
    _level.snakeAlive = false;
  }

  num _calculateImageRotation() {
    if (_previousAngle != _angle) {
      var completion;
      if (_angle == 0) {
        completion = _location.x % Level.gridSize / Level.gridSize;
      } else if (_angle == 90) {
        completion = _location.y % Level.gridSize / Level.gridSize;
      } else if (_angle == 180) {
        completion = (Level.gridSize - _location.x % Level.gridSize) /
                     Level.gridSize;
      } else if (_angle == 270) {
        completion = (Level.gridSize - _location.y % Level.gridSize) /
                     Level.gridSize;
      }
      if (_previousAngle == 0 && _angle == 270) {
        return _degreesToRadians(360 - 90 * completion);
      } else if ( _angle > _previousAngle ||
                  (_angle == 0 && _previousAngle == 270) ) {
        return _degreesToRadians(_previousAngle + 90 * completion);
      } else {
        return _degreesToRadians(_previousAngle + -90 * completion);
      }
    } else {
      return _degreesToRadians(_angle);
    }
  }

  void _turnTo(int newAngle) {
    _previousAngle = _angle;

    super._turnTo(newAngle);
  }
}
