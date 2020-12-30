import 'dart:convert' as Convert;

import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/models/player_settings.dart';
import 'package:flutter_app/screens/timer/timer_screen.dart';
import 'package:flutter_app/utils/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartButton extends StatelessWidget {
  final int orientation;
  final List<PlayerSettings> playersSettings;
  final Duration duration;
  final bool remember;

  const StartButton(
      {Key key,
      this.orientation,
      this.playersSettings,
      this.duration,
      this.remember})
      : super(key: key);

  void _savePrefs(GameSettings gameSettings) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences
        .setBool(PreferenceKeys.saveChanges, remember)
        .then((value) => print('Remember flag was stored successfully.'))
        .catchError((e) => print('Remember flag could not be stored: $e'));

    if (remember) {
      String json = Convert.jsonEncode(gameSettings.toMap());
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

  @override
  Widget build(BuildContext context) {
    void _openTimerScreen() {
      GameSettings gameSettings = GameSettings(
        playerSettings: playersSettings,
        orientation: orientation,
        duration: duration,
      );

      _savePrefs(gameSettings);

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimerScreen(
            gameSettings: gameSettings,
          ),
        ),
      );
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
