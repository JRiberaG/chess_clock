import 'package:flutter/material.dart';
import 'package:flutter_app/models/providers/game_settings_provider.dart';
import 'package:flutter_app/models/providers/remember_provider.dart';
import 'package:flutter_app/screens/initial/initial_screen.dart';
import 'package:flutter_app/utils/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameSettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RememberProvider(),
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // fontFamily: 'SF_Pro',
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: routes,
          initialRoute: InitialScreen.routeName,
        ),
      ),
    );
  }
}
