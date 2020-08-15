import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:swipe_maze/maze.dart';

class SwipeMazeScreen5 extends StatefulWidget {
  final Maze maze;

  const SwipeMazeScreen5(this.maze);

  @override
  _SwipeMazeScreen5State createState() => _SwipeMazeScreen5State(
        pageX: maze.start.x,
        pageY: maze.start.y,
      );
}

class _SwipeMazeScreen5State extends State<SwipeMazeScreen5> {
  int pageX = 0;
  int pageY = 0;
  double deltaX = 0;
  double deltaY = 0;
  double maxWidth = 0;
  double maxHeight = 0;

  _SwipeMazeScreen5State({this.pageX, this.pageY});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (maxWidth == 0) {
              maxWidth = constraints.maxWidth;
            }

            if (maxHeight == 0) {
              maxHeight = constraints.maxHeight;
            }

            return GestureDetector(
              onHorizontalDragEnd: (details) {
                setState(() {
                  if (deltaX.abs() >= (constraints.maxWidth / 4)) {
                    if (deltaX < 0) {
                      pageX--;
                    } else {
                      pageX++;
                    }
                  }

                  deltaX = 0;
                });
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  if (deltaY == 0) {
                    deltaX += details.delta.dx;
                  }
                });
              },
              onVerticalDragEnd: (details) {
                setState(() {
                  if (deltaY.abs() >= (constraints.maxHeight / 4)) {
                    if (deltaY < 0) {
                      pageY--;
                    } else {
                      pageY++;
                    }
                  }

                  deltaY = 0;
                });
              },
              onVerticalDragUpdate: (details) {
                setState(() {
                  if (deltaX == 0) {
                    deltaY += details.delta.dy;
                  }
                });
              },
              child: MazeCanvas(
                x: (pageX * maxWidth) + deltaX,
                y: (pageY * maxHeight) + deltaY,
                maze: widget.maze,
              ),
            );
          },
        ),
      ),
    );
  }
}

class MazeCanvas extends StatelessWidget {
  final double x;
  final double y;
  final Maze maze;

  const MazeCanvas({this.x, this.y, this.maze});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TestMazePainter(
        matrix: matrix,
        maze: maze,
      ),
    );
  }

  Matrix4 get matrix => Matrix4Transform()
      .translate(
        x: x,
        y: y,
      )
      .matrix4;
}

class TestMazePainter extends CustomPainter {
  final Matrix4 matrix;
  final Maze maze;

  const TestMazePainter({
    this.matrix,
    this.maze,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.transform(matrix.storage);

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        final Paint paint = Paint();
        paint.color = _color(i, j);

        canvas.drawRect(
          Rect.fromLTWH(
            i * size.width,
            j * size.height,
            size.width,
            size.height,
          ),
          paint,
        );

        final TextSpan span = TextSpan(
          style: TextStyle(color: Colors.white),
          text: '$i,$j',
        );
        final TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(
          canvas,
          Offset(
            (i * size.width) + (size.width / 2),
            (j * size.height) + (size.height / 2),
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Color _color(int i, int j) => Color.fromARGB(
      255, (i * 100) % 255, (j * 100) % 255, (i * j * 100) % 255);
}

class MazePainter extends CustomPainter {
  final Matrix4 matrix;
  final Maze maze;

  const MazePainter({this.matrix, this.maze});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.transform(matrix.storage);

    final paintWalls = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final paintStart = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final paintEnd = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 5; i++) {
      // TODO(momo): remove harcoded width
      for (int j = 0; j < 5; j++) {
        // TODO(momo): remove harcoded height

        final path = Path();

        // top-left
        path.addRect(Rect.fromLTWH(
          i * size.width,
          j * size.height,
          size.width * 1 / 3,
          size.height * 1 / 3,
        ));

        // top-right
        path.addRect(Rect.fromLTWH(
          (i * size.width) + (size.width * 2 / 3),
          j * size.height,
          size.width,
          size.height * 1 / 3,
        ));

        // bottom-right
        path.addRect(Rect.fromLTWH(
          (i * size.width) + (size.width * 2 / 3),
          (j * size.height) + (size.height * 2 / 3),
          size.width,
          size.height,
        ));

        // bottom-left
        path.addRect(Rect.fromLTWH(
          i * size.width,
          (j * size.height) + (size.height * 2 / 3),
          size.width * 1 / 3,
          size.height,
        ));

        if (maze.isClosed(i + 0, j - 1)) {
          path.addRect(Rect.fromLTWH(
            (i * size.width) + (size.width * 1 / 3),
            j * size.height,
            size.width * 2 / 3,
            size.height * 1 / 3,
          ));
        }

        if (maze.isClosed(i + 1, j + 0)) {
          path.addRect(Rect.fromLTWH(
            (i * size.width) + (size.width * 2 / 3),
            (j * size.height) + size.height * 1 / 3,
            size.width,
            size.height * 2 / 3,
          ));
        }

        if (maze.isClosed(i + 0, j + 1)) {
          path.addRect(Rect.fromLTWH(
            (i * size.width) + (size.width * 1 / 3),
            (j * size.height) + (size.height * 2 / 3),
            size.width * 2 / 3,
            size.height,
          ));
        }

        if (maze.isClosed(i - 1, j + 0)) {
          path.addRect(Rect.fromLTWH(
            i * size.width,
            (j * size.height) + (size.height * 1 / 3),
            size.width * 1 / 3,
            size.height * 2 / 3,
          ));
        }

        if (maze.isStart(i, j)) {
          canvas.drawCircle(
            Offset(
              (i * size.width) + (size.width / 2),
              (j * size.height) + (size.height / 2),
            ),
            size.width / 12,
            paintStart,
          );
        }

        if (maze.isEnd(i, j)) {
          canvas.drawCircle(
            Offset(
              (i * size.width) + (size.width / 2),
              (j * size.height) + (size.height / 2),
            ),
            size.width / 12,
            paintEnd,
          );
        }

        canvas.drawPath(path, paintWalls);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
