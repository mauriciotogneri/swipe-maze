import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';
import 'package:swipe_maze/tile.dart';

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
        x: x,
        y: y,
        maze: widget.maze,
      ),
    );
  }
}
