import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe_maze/swipe_maze_app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(SwipeMazeApp());
}
