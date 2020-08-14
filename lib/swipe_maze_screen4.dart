import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';
import 'package:swipe_maze/tile.dart';

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
  int lastVerticalPage = 1000;
  int lastHorizontalPage = 1000;
  final controllerVertical = new PageController(initialPage: 1000);
  final controllerHorizontal = new PageController(initialPage: 1000);

  _SwipeMazeScreen4State({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controllerVertical,
      scrollDirection: Axis.vertical,
      onPageChanged: _onVerticalScroll,
      itemBuilder: (context, index) {
        return PageView.builder(
          controller: controllerHorizontal,
          scrollDirection: Axis.horizontal,
          onPageChanged: _onHorizontalScroll,
          itemBuilder: (context, index) => Tile(
            x: x,
            y: y,
            maze: widget.maze,
          ),
        );
      },
    );
  }

  void _onVerticalScroll(int page) {
    setState(() {
      y += page - lastVerticalPage;
      lastVerticalPage = page;
      lastHorizontalPage = 1000;
    });
  }

  void _onHorizontalScroll(int page) {
    setState(() {
      x += page - lastHorizontalPage;
      lastHorizontalPage = page;
    });
  }
}
