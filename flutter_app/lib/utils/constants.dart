import 'package:flutter/material.dart';

const SEPARATOR_PADDING = const EdgeInsets.only(top: 20);

class Col {
  static final blue = 0xFF90caf9;
  static final green = 0xFFa5d6a7;
  static final red = 0xFFef9a9a;
  static final brown = 0xFFbcaaa4;
  static final white = 0xFFfafafa;
  static final black = 0xFF212121;
  static final selected = Colors.brown[200];
}

/// Orange color
const int DEFAULT_COLOR = 0xFFFFA726;

TextStyle buttonStyle() {
  return TextStyle(
    fontSize: 20,
  );
}
