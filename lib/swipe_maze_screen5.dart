import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:swipe_maze/maze.dart';

class SwipeMazeScreen5 extends StatefulWidget {
  final Maze maze;

  const SwipeMazeScreen5(this.maze);

  @override
  _SwipeMazeScreen5State createState() => _SwipeMazeScreen5State(
        offsetX: maze.start.x.toDouble(),
        offsetY: maze.start.y.toDouble(),
      );
}

class _SwipeMazeScreen5State extends State<SwipeMazeScreen5> {
  double offsetX = 0;
  double offsetY = 0;
  double deltaX = 0;
  double deltaY = 0;

  _SwipeMazeScreen5State({this.offsetX, this.offsetY});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onHorizontalDragEnd: (details) {
                setState(() {
                  if (deltaX.abs() >= (constraints.maxWidth / 4)) {
                    offsetX -= constraints.maxWidth;
                  }

                  deltaX = 0;
                });
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  if (deltaY == 0) {
                    deltaX += details.delta.dx * 2;
                  }
                });
              },
              onVerticalDragEnd: (details) {
                setState(() {
                  if (deltaY.abs() >= (constraints.maxHeight / 4)) {
                    offsetY -= constraints.maxHeight;
                  }

                  deltaY = 0;
                });
              },
              onVerticalDragUpdate: (details) {
                setState(() {
                  if (deltaX == 0) {
                    deltaY += details.delta.dy * 2;
                  }
                });
              },
              child: TileCanvas(
                matrix: matrix,
                maze: widget.maze,
              ),
            );
          },
        ),
      ),
    );
  }

  Matrix4 get matrix => Matrix4Transform()
      .translate(
        x: offsetX + deltaX,
        y: offsetY + deltaY,
      )
      .matrix4;
}

class TileCanvas extends StatelessWidget {
  final Matrix4 matrix;
  final Maze maze;

  const TileCanvas({this.matrix, this.maze});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TilePainter(
        matrix: matrix,
      ),
    );
  }
}

class TilePainter extends CustomPainter {
  final Matrix4 matrix;
  final bool closedTop;
  final bool closedRight;
  final bool closedBottom;
  final bool closedLeft;
  final bool isStart;
  final bool isEnd;

  const TilePainter({
    this.matrix,
    this.closedTop,
    this.closedRight,
    this.closedBottom,
    this.closedLeft,
    this.isStart,
    this.isEnd,
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
