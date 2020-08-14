import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';

class SwipeMazeScreen5 extends StatefulWidget {
  final Maze maze;

  const SwipeMazeScreen5(this.maze);

  @override
  _SwipeMazeScreen5State createState() => _SwipeMazeScreen5State(
        x: maze.start.x,
        y: maze.start.y,
      );
}

class _SwipeMazeScreen5State extends State<SwipeMazeScreen5> {
  int x = 0;
  int y = 0;

  _SwipeMazeScreen5State({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
