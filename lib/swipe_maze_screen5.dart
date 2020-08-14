import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:swipe_maze/maze.dart';

class SwipeMazeScreen5 extends StatefulWidget {
  final Maze maze;

  const SwipeMazeScreen5(this.maze);

  @override
  _SwipeMazeScreen5State createState() => _SwipeMazeScreen5State(
        x: maze.start.x.toDouble(),
        y: maze.start.y.toDouble(),
      );
}

class _SwipeMazeScreen5State extends State<SwipeMazeScreen5> {
  double x = 0;
  double y = 0;
  Matrix4 matrix = Matrix4.identity();

  _SwipeMazeScreen5State({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              x += details.delta.dx;
              y += details.delta.dy;
              matrix = Matrix4Transform().translate(x: x, y: y).matrix4;
            });
          },
          child: ClickableCanvas(matrix),
        ),
      ),
    );
  }
}

class ClickableCanvas extends StatelessWidget {
  final Matrix4 matrix;

  const ClickableCanvas(this.matrix);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MapPainter(matrix),
    );
  }
}

class MapPainter extends CustomPainter {
  final Matrix4 matrix;

  const MapPainter(this.matrix);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.transform(matrix.storage);

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        final Paint paint = Paint();
        paint.color = _color(i, j);

        canvas.drawRect(
            Rect.fromLTWH(
                i * size.width, j * size.height, size.width, size.height),
            paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Color _color(int i, int j) => Color.fromARGB(
      255, (i * 100) % 255, (j * 100) % 255, (i * j * 100) % 255);
}
