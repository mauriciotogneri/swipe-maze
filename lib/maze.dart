import 'dart:math';

class Maze {
  final Point<int> start;
  final Point<int> end;
  final List<Point<int>> path;

  Maze({this.start, this.end, this.path});

  bool isStart(int x, int y) => (start.x == x) && (start.y == y);

  bool isEnd(int x, int y) => (end.x == x) && (end.y == y);

  bool isClosed(int x, int y) {
    for (final point in path) {
      if ((point.x == x) && (point.y == y)) {
        return false;
      }
    }

    return true;
  }
}
