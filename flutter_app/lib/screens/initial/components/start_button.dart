import 'dart:convert' as Convert;

import 'package:flutter/material.dart';
import 'package:flutter_app/models/providers/game_settings_provider.dart';
import 'package:flutter_app/models/providers/remember_provider.dart';
import 'package:flutter_app/screens/timer/clock_screen.dart';
import 'package:flutter_app/utils/preference_keys.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerGameSettings = Provider.of<GameSettingsProvider>(context);
    final providerRemember = Provider.of<RememberProvider>(context);

    void _savePrefs() async {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences
          .setBool(PreferenceKeys.saveChanges, providerRemember.remember)
          .then((value) => print('Remember flag was stored successfully.'))
          .catchError((e) => print('Remember flag could not be stored: $e'));

      if (providerRemember.remember) {
        String json =
            Convert.jsonEncode(providerGameSettings.gameSettings.toMap());
        sharedPreferences
            .setString(PreferenceKeys.gameSettings, json)
            .then((value) => print('Game settings were stored successfully.'))
            .catchError((e) => print('Game settings could not be stored: $e'));
      } else {
        sharedPreferences
            .remove(PreferenceKeys.gameSettings)
            .catchError((e) => print('Game settings could not be removed: $e'));
      }
    }

    void _openTimerScreen() {
      _savePrefs();

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClockScreen(
            gameSettings: providerGameSettings.gameSettings,
          ),
        ),
      );
      // Navigator.popAndPushNamed(context, ClockScreen.routeName);
    }

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        width: double.infinity,
        child: RaisedButton.icon(
          splashColor: Colors.transparent,
          color: Colors.brown[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          icon: Icon(
            Icons.play_arrow,
            size: 36,
          ),
          label: Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              'START',
              style: TextStyle(fontSize: 20),
            ),
          ),
          onPressed: () => _openTimerScreen(),
        ),
      ),
    );
  }
}
