import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:flutter_app/utils/utils.dart';

const BACKGROUND = 0;
const ICON = 1;
const TEXT = 2;
const NAME = 3;

class PlayerSection extends StatefulWidget {
  final Function fun;
  final bool isActive;
  final int seconds;
  final bool isPlayerOne;

  final GameSettings gameSettings;

  const PlayerSection(
      {this.fun,
      this.isActive,
      this.seconds,
      this.gameSettings,
      this.isPlayerOne});

  @override
  _PlayerSectionState createState() => _PlayerSectionState();
}

class _PlayerSectionState extends State<PlayerSection> {
  final durationOpacity = 200;
  final int up = 1;
  final int down = 3;

  String _getName() {
    String name = widget.isPlayerOne
        ? widget.gameSettings.playerSettings[0].name
        : widget.gameSettings.playerSettings[1].name;

    if (name != null && name.isNotEmpty) return name;

    return '';
  }

  int _getColor(int what) {
    int backgroundColor;

    if (widget.isPlayerOne) {
      backgroundColor = widget.gameSettings.playerSettings[0].colorHex;
    } else {
      backgroundColor = widget.gameSettings.playerSettings[1].colorHex;
    }

    if (what == BACKGROUND) {
      // The color requested is for the Background -> Returns it if not null or
      // a generic one otherwise
      return backgroundColor ?? Color(0xFFE1c699);
    } else {
      // The color requested is for either the Icon or the Text -> if the background
      // color is dark, returns a bright color, otherwise returns the opposite
      if (backgroundColor != Col.black) {
        return what == NAME ? 0xFF212121 : Col.black;
      } else {
        return 0xFFf5f5f5;
      }
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
            color: Color(_getColor(BACKGROUND)),
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
                      color: Color(_getColor(ICON)),
                      // Color(0xFF333333),
                    ),
                  ),
                  Text(
                    formatDuration(Duration(seconds: widget.seconds)),
                    // _formatSeconds(widget.seconds),
                    style: TextStyle(
                      fontSize: ScreenSize.h / 10,
                      fontWeight: FontWeight.w300,
                      color: Color(_getColor(TEXT)),
                    ),
                  ),
                  Text(
                    _getName(),
                    style: TextStyle(
                      fontSize: ScreenSize.h / 20,
                      fontWeight: FontWeight.w200,
                      color: Color(_getColor(NAME)),
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
