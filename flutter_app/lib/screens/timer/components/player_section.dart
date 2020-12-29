import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:flutter_app/utils/utils.dart';

class PlayerSection extends StatefulWidget {
  final Function fun;
  final bool isActive;
  final int seconds;
  final bool playerOne;

  final GameSettings gameSettings;

  const PlayerSection(
      {this.fun,
      this.isActive,
      this.seconds,
      this.gameSettings,
      this.playerOne});

  @override
  _PlayerSectionState createState() => _PlayerSectionState();
}

class _PlayerSectionState extends State<PlayerSection> {
  int durationOpacity = 200;
  int up = 1;
  int down = 3;

  // String _formatSeconds(int seconds) {
  //   Duration duration = Duration(seconds: seconds);
  //
  //   String twoDigits(int n) =>
  //       n.toString().padLeft(2, '0'); // Adds a 0 if needed
  //   String strMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String strSeconds = twoDigits(duration.inSeconds.remainder(60));
  //
  //   return '$strMinutes:$strSeconds';
  // }

  String _getName() {
    String nameP1 = widget.gameSettings.playerSettings[0].name;
    String nameP2 = widget.gameSettings.playerSettings[1].name;
    if (widget.playerOne) {
      if (nameP1 != null) {
        if (nameP1.isEmpty) {
          return 'Player 2';
        } else {
          return nameP1;
        }
      }
    } else {
      if (nameP2 != null) {
        if (nameP2.isEmpty) {
          return 'Player 2';
        } else {
          return nameP2;
        }
      }
    }

    return '';
  }

  Color _getColor() {
    Color colorP1 = widget.gameSettings.playerSettings[0].color;
    Color colorP2 = widget.gameSettings.playerSettings[1].color;

    if (widget.playerOne) {
      return colorP1 ?? Color(0xFFE1c699);
    } else {
      return colorP2 ?? Color(0xFFE1c699);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 20,
      child: GestureDetector(
        onTap: () => widget.fun(),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: durationOpacity),
          opacity: widget.isActive ? 1 : 0.5,
          child: Container(
            width: double.infinity,
            color: _getColor(),
            child: RotatedBox(
              quarterTurns: widget.gameSettings.orientation == LEFT ? 3 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: durationOpacity),
                    opacity: widget.isActive ? 1 : 0,
                    child: Icon(
                      Icons.timer,
                      size: ScreenSize.h / 15,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Text(
                    formatDuration(Duration(seconds: widget.seconds)),
                    // _formatSeconds(widget.seconds),
                    style: TextStyle(
                      fontSize: ScreenSize.h / 10,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _getName(),
                    style: TextStyle(
                      fontSize: ScreenSize.h / 20,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey[900],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
