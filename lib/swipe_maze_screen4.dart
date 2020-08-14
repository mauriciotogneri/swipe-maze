import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';
import 'package:swipe_maze/test_tile.dart';

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
  final PageController controller = PageController();

  _SwipeMazeScreen4State({this.x, this.y});

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.page.round() != 1) {
        setState(() {
          x = controller.page.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: PageScrollPhysics(),
      controller: controller,
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverFillViewport(
          delegate: SliverChildListDelegate([
            TestTile(
              x: x - 1,
              y: 0,
            ),
            TestTile(
              x: x,
              y: 0,
            ),
            TestTile(
              x: x + 1,
              y: 0,
            ),
          ]),
        ),
      ],
    );
  }
}
