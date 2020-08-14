import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:swipe_maze/maze.dart';
import 'package:swipe_maze/test_tile.dart';

class SwipeMazeScreen2 extends StatefulWidget {
  final Maze maze;

  const SwipeMazeScreen2(this.maze);

  @override
  _SwipeMazeScreen2State createState() => _SwipeMazeScreen2State(
        x: maze.start.x,
        y: maze.start.y,
      );
}

class _SwipeMazeScreen2State extends State<SwipeMazeScreen2> {
  int x = 0;
  int y = 0;
  int lastVerticalPage = 0;
  int lastHorizontalPage = 0;

  _SwipeMazeScreen2State({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return LoopPageView.builder(
      scrollDirection: Axis.vertical,
      onPageChanged: _onVerticalScroll,
      itemCount: 3,
      itemBuilder: (context, index) {
        return LoopPageView.builder(
          scrollDirection: Axis.horizontal,
          onPageChanged: _onHorizontalScroll,
          itemCount: 3,
          itemBuilder: (context, index) {
            return TestTile(
              x: x,
              y: y,
            );
          },
        );
      },
    );
  }

  // 2
  // 0
  // 1
  void _onVerticalScroll(int page) {
    print('$page $lastVerticalPage');

    if (page == 0) {
      if (lastVerticalPage == 1) {
        print('a');
        // up
        setState(() {
          y++;
        });
      } else if (lastVerticalPage == 2) {
        print('b');
        // down
        setState(() {
          y--;
        });
      }
    } else if (page == 1) {
      if (lastVerticalPage == 0) {
        print('c');
        // down
        setState(() {
          y--;
        });
      } else if (lastVerticalPage == 2) {
        print('d');
        // up
        setState(() {
          y++;
        });
      }
    } else if (page == 2) {
      if (lastVerticalPage == 0) {
        print('e');
        // up
        setState(() {
          y++;
        });
      } else if (lastVerticalPage == 1) {
        print('f');
        // down
        setState(() {
          y--;
        });
      }
    }

    //print('$x $y');

    lastVerticalPage = page;
  }

  void _onHorizontalScroll(int page) {
    /*print(page);
    print(page - lastPage);
    print(lastPage - page);
    print('------------');
    lastPage = page;*/
  }
}