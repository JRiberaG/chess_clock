import 'package:flutter/material.dart';
import 'package:flutter_app/screens/initial/initial_screen.dart';
import 'package:flutter_app/utils/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chess Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      // initialRoute: TimerScreen.routeName,
      initialRoute: InitialScreen.routeName,
    );
  }
}
