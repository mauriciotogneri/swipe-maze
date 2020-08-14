import 'package:flutter/material.dart';

class TestTile extends StatelessWidget {
  final int x;
  final int y;

  TestTile({this.x, this.y}) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$x,$y'),
    );
  }
}
