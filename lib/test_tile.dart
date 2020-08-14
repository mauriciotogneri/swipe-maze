import 'package:flutter/material.dart';

class TestTile extends StatelessWidget {
  final int x;
  final int y;

  TestTile({this.x, this.y}) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _randomColor(),
      child: Center(
        child: Text('$x,$y'),
      ),
    );
  }

  Color _randomColor() => Color.fromARGB(
      255, (x * 100) % 255, (y * 100) % 255, (x * y * 100) % 255);
}
