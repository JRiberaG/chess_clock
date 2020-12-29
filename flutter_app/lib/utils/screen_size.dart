import 'package:flutter/material.dart';

class ScreenSize {
  static MediaQueryData _mediaQueryData;

  /// Devices screen Width.
  static double w;

  /// Device's screen Height.
  static double h;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    w = _mediaQueryData.size.width;
    h = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Gets the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  var x = (inputHeight / 812) * ScreenSize.h;
  // print('ProportionalScreenHeight is $x');
  return x;
}

// Gets the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  var x = (inputWidth / 375) * ScreenSize.w;
  // print('ProportionalScreenWidth is $x');
  return x;
}
