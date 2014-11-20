part of snake;

class Point {
  final int x;
  final int y;

  int get hashCode {
    int result = 17;
    result = 37 * result + x.hashCode;
    result = 37 * result + y.hashCode;
    return result;
  }

  const Point(this.x, this.y);

  bool operator ==(Point other) {
    if (other is! Point) { return false; }

    return x == other.x && y == other.y;
  }

  String toString() {
    return "($x,$y)";
  }
}
