import 'package:flutter/material.dart';
import 'package:flutter_app/utils/screen_size.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'ChessTimer',
      style: TextStyle(
        fontSize: ScreenSize.w / 10,
        fontWeight: FontWeight.w300,
        color: Colors.blue[800],
      ),
    );
  }
}
