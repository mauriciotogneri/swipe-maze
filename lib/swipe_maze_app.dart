import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swipe_maze/maze.dart';
import 'package:swipe_maze/swipe_maze_screen5.dart';

class SwipeMazeApp extends StatelessWidget {
  final Maze maze = Maze(
    width: 11,
    height: 11,
    start: Point<int>(0, 1),
    end: Point<int>(10, 9),
    path: [
      Point(0, 1),
      Point(1, 1),
      Point(2, 1),
      Point(3, 1),
      Point(5, 1),
      Point(6, 1),
      Point(7, 1),
      Point(8, 1),
      Point(9, 1),
      Point(1, 2),
      Point(3, 2),
      Point(5, 2),
      Point(9, 2),
      Point(1, 3),
      Point(3, 3),
      Point(4, 3),
      Point(5, 3),
      Point(7, 3),
      Point(8, 3),
      Point(9, 3),
      Point(1, 4),
      Point(7, 4),
      Point(1, 5),
      Point(3, 5),
      Point(4, 5),
      Point(5, 5),
      Point(7, 5),
      Point(8, 5),
      Point(9, 5),
      Point(1, 6),
      Point(3, 6),
      Point(9, 6),
      Point(1, 7),
      Point(3, 7),
      Point(5, 7),
      Point(6, 7),
      Point(7, 7),
      Point(9, 7),
      Point(1, 8),
      Point(3, 8),
      Point(5, 8),
      Point(7, 8),
      Point(9, 8),
      Point(1, 9),
      Point(2, 9),
      Point(3, 9),
      Point(5, 9),
      Point(7, 9),
      Point(8, 9),
      Point(9, 9),
      Point(10, 9),
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
