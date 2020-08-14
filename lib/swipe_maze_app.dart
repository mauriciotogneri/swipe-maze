import 'package:flutter/material.dart';
import 'package:swipe_maze/swipe_maze_screen.dart';

class SwipeMazeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwipeMazeScreen(),
    );
  }
}
