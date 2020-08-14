import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';

class SwipeMazeScreen extends StatefulWidget {
  final Maze maze;

  const SwipeMazeScreen(this.maze);

  @override
  _SwipeMazeScreenState createState() => _SwipeMazeScreenState(
        x: maze.start.x,
        y: maze.start.y,
      );
}

class _SwipeMazeScreenState extends State<SwipeMazeScreen> {
  int x = 0;
  int y = 0;

  _SwipeMazeScreenState({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          setState(() {
            if (!widget.maze.isClosed(x - 1, y)) {
              x--;
            }
          });
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          setState(() {
            if (!widget.maze.isClosed(x + 1, y)) {
              x++;
            }
          });
        }
      },
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy < 0) {
          setState(() {
            if (!widget.maze.isClosed(x, y + 1)) {
              y++;
            }
          });
        } else if (details.velocity.pixelsPerSecond.dy > 0) {
          setState(() {
            if (!widget.maze.isClosed(x, y - 1)) {
              y--;
            }
          });
        }
      },
      child: Tile(
        closedTop: widget.maze.isClosed(x + 0, y - 1),
        closedRight: widget.maze.isClosed(x + 1, y + 0),
        closedBottom: widget.maze.isClosed(x + 0, y + 1),
        closedLeft: widget.maze.isClosed(x - 1, y + 0),
        isStart: widget.maze.isStart(x, y),
        isEnd: widget.maze.isEnd(x, y),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final bool closedTop;
  final bool closedRight;
  final bool closedBottom;
  final bool closedLeft;
  final bool isStart;
  final bool isEnd;

  Tile({
    this.closedTop,
    this.closedRight,
    this.closedBottom,
    this.closedLeft,
    this.isStart,
    this.isEnd,
  }) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: CustomPaint(
        painter: TilePainter(
          closedTop: closedTop,
          closedRight: closedRight,
          closedBottom: closedBottom,
          closedLeft: closedLeft,
          isStart: isStart,
          isEnd: isEnd,
        ),
      ),
    );
  }
}

class TilePainter extends CustomPainter {
  final bool closedTop;
  final bool closedRight;
  final bool closedBottom;
  final bool closedLeft;
  final bool isStart;
  final bool isEnd;

  const TilePainter({
    this.closedTop,
    this.closedRight,
    this.closedBottom,
    this.closedLeft,
    this.isStart,
    this.isEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintWalls = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final paintStart = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final paintEnd = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path();

    // top-left
    path.addRect(Rect.fromLTRB(
      0,
      0,
      size.width * 1 / 3,
      size.height * 1 / 3,
    ));

    // top-right
    path.addRect(Rect.fromLTRB(
      size.width * 2 / 3,
      0,
      size.width,
      size.height * 1 / 3,
    ));

    // bottom-right
    path.addRect(Rect.fromLTRB(
      size.width * 2 / 3,
      size.height * 2 / 3,
      size.width,
      size.height,
    ));

    // bottom-left
    path.addRect(Rect.fromLTRB(
      0,
      size.height * 2 / 3,
      size.width * 1 / 3,
      size.height,
    ));

    if (closedTop) {
      path.addRect(Rect.fromLTRB(
        size.width * 1 / 3,
        0,
        size.width * 2 / 3,
        size.height * 1 / 3,
      ));
    }

    if (closedRight) {
      path.addRect(Rect.fromLTRB(
        size.width * 2 / 3,
        size.height * 1 / 3,
        size.width,
        size.height * 2 / 3,
      ));
    }

    if (closedBottom) {
      path.addRect(Rect.fromLTRB(
        size.width * 1 / 3,
        size.height * 2 / 3,
        size.width * 2 / 3,
        size.height,
      ));
    }

    if (closedLeft) {
      path.addRect(Rect.fromLTRB(
        0,
        size.height * 1 / 3,
        size.width * 1 / 3,
        size.height * 2 / 3,
      ));
    }

    if (isStart) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width / 12,
        paintStart,
      );
    }

    if (isEnd) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width / 12,
        paintEnd,
      );
    }

    canvas.drawPath(path, paintWalls);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
