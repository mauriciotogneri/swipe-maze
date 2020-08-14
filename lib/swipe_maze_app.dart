import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';
import 'package:swipe_maze/swipe_maze_screen5.dart';

class SwipeMazeApp extends StatelessWidget {
  //   0 1 2 3
  // 0 X O X X
  // 1 X O O X
  // 2 X X O X
  // 3 O O O X
  final Maze maze = Maze(
    start: Point<int>(0, 3),
    end: Point<int>(1, 0),
    path: [
      Point(1, 0),
      Point(1, 1),
      Point(2, 1),
      Point(2, 2),
      Point(0, 3),
      Point(1, 3),
      Point(2, 3),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SwipeMazeScreen5(maze),
      ),
    );
  }
}
