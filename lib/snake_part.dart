part of snake;

class SnakePart extends Actor {
  final Map<Point, int> _q;

  SnakePart(_game, _screen, _location, _size, _image, _angle, this._q) :
    super(_game, _screen, _location, _size, _image, _angle);

  Level get _level => _screen as Level;

  void update() {
    if (this is! SnakeHead && _alignedWithGrid()) {
      var newAngle = _q[locationInGrid()];
      if (newAngle == null) { print("No move queued"); }
      _turnTo(newAngle);
    }
    _location = _calculateNewLocation();
  }

  void render(CanvasRenderingContext2D context, num frameDelta) {
    var halfWidth  = _size.width  ~/ 2;
    var halfHeight = _size.height ~/ 2;
    var centerX    = _location.x + halfWidth;
    var centerY    = _location.y + halfHeight;
    var rotation   = _calculateImageRotation();

    context.translate(centerX, centerY);
    context.rotate(rotation);
    context.drawImageScaled(
        _image,
        -halfWidth,
        -halfHeight,
        _size.width,
        _size.height
    );
    context.rotate(-rotation);
    context.translate(-centerX, -centerY);
  }

  bool _alignedWithGrid() {
    return (_angle == 0   && _location.x % Level.gridSize == 0) ||
           (_angle == 90  && _location.y % Level.gridSize == 0) ||
           (_angle == 180 && _location.x % Level.gridSize == 0) ||
           (_angle == 270 && _location.y % Level.gridSize == 0);
  }

  Point locationInGrid([Point location]) {
    var xy = location == null ? _location : location;
    return new Point(xy.x ~/ Level.gridSize, xy.y ~/ Level.gridSize);
  }

  Point _calculateNewLocation() {
    Point result;
    switch (_angle) {
      case 0:
        result =  new Point(_location.x + _level.snakeVelocity, _location.y);
        break;

      case 90:
        result = new Point(_location.x, _location.y + _level.snakeVelocity);
        break;

      case 180:
        result = new Point(_location.x - _level.snakeVelocity, _location.y);
        break;

      case 270:
        result = new Point(_location.x, _location.y - _level.snakeVelocity);
        break;

      default:
        throw new Exception("Bad angle $_angle");
    }

    return result;
  }

  num _degreesToRadians(num degrees) {
    return degrees * (PI / 180.0);
  }

  int _nextAngle() {
    var currentLocation = locationInGrid();
    var currentAngle    = _q[currentLocation];
    if ((_angle == 0 || _angle == 90) && _angle == currentAngle) {
      var nextLocation;
      switch (_angle) {
        case 0:
          nextLocation = new Point(currentLocation.x + 1, currentLocation.y);
          break;
        case 90:
          nextLocation = new Point(currentLocation.x,     currentLocation.y + 1);
          break;
        case 180:
          nextLocation = new Point(currentLocation.x - 1, currentLocation.y);
          break;
        case 270:
          nextLocation = new Point(currentLocation.x,     currentLocation.y - 1);
          break;
        default:
          print("Bad angle error");
          break;
      }
      var nextAngle = _q[nextLocation];
      if (nextAngle == null) { print("No queued angle"); }
      return nextAngle;
    } else {
      return currentAngle;
    }
  }

  num _calculateImageRotation() {
    var nextAngle = _nextAngle();

    if (_angle != nextAngle) {
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
      if (_angle == 0 && nextAngle == 270) {
        return _degreesToRadians(360 - 90 * completion);
      } else if ( nextAngle > _angle ||
                  (nextAngle == 0 && _angle == 270) ) {
        return _degreesToRadians(_angle + 90 * completion);
      } else {
        return _degreesToRadians(_angle + -90 * completion);
      }
    } else {
      return _degreesToRadians(_angle);
    }
  }

  void _turnTo(int newAngle) {
    _angle = newAngle;
  }
}
