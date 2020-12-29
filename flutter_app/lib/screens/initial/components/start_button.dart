import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/models/player_settings.dart';
import 'package:flutter_app/screens/timer/timer_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    _openTimerScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimerScreen(
            gameSettings: GameSettings(
              playerSettings: playersSettings,
              orientation: orientation,
              duration: duration,
            ),
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
          color: Colors.blue[100],
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
