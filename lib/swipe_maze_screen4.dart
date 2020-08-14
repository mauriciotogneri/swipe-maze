import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';

class SwipeMazeScreen4 extends StatefulWidget {
  final Maze maze;

  const SwipeMazeScreen4(this.maze);

  @override
  _SwipeMazeScreen4State createState() => _SwipeMazeScreen4State(
        x: maze.start.x,
        y: maze.start.y,
      );
}

class _SwipeMazeScreen4State extends State<SwipeMazeScreen4> {
  int x = 0;
  int y = 0;

  _SwipeMazeScreen4State({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              color: _randomColor(index),
            );
          }),
        ),
      ],
    );
  }

  Color _randomColor(int index) {
    if (index % 3 == 0) {
      return Colors.pink;
    } else if (index % 3 == 1) {
      return Colors.blueAccent;
    }

    return Colors.amber;
  }
}
