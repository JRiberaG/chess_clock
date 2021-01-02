import 'package:flutter/material.dart';
import 'package:flutter_app/screens/initial/initial_screen.dart';
import 'package:flutter_app/screens/timer/clock_screen.dart';

Map<String, WidgetBuilder> routes = {
  InitialScreen.routeName: (context) => InitialScreen(),
  ClockScreen.routeName: (context) => ClockScreen(),
};
