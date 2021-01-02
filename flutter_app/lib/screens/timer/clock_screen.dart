import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/screens/initial/initial_screen.dart';
import 'package:flutter_app/screens/timer/components/dialog_buttons.dart';
import 'package:flutter_app/screens/timer/components/player_section.dart';
import 'package:flutter_app/utils/constants.dart';

import 'components/separator.dart';

const String _TAG = 'TimerScreen';
const TOP = 0;
const BOT = 1;
const NONE = -1;

class ClockScreen extends StatefulWidget {
  static final routeName = '/timer_screen';

  final GameSettings gameSettings;

  const ClockScreen({@required this.gameSettings});

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  // Timers
  Timer timerTop;
  Timer timerBot;

  // Flags to decide which timer counts down
  bool isTopActive;
  bool isBotActive;

  // Seconds left of each player
  int secsTop;
  int secsBot;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    if (timerTop != null) {
      timerTop.cancel();
      timerTop = null;
    }

    if (timerBot != null) {
      timerBot.cancel();
      timerBot = null;
    }

    isBotActive = false;
    isTopActive = false;
    secsTop = widget.gameSettings.duration.inSeconds;
    secsBot = widget.gameSettings.duration.inSeconds;

    setState(() {});
  }

  _initTimersIfNeeded() {
    if (timerTop == null) {
      timerTop = Timer.periodic(Duration(seconds: 1), (_) {
        _handleTickLeft();
      });
    }
    if (timerBot == null) {
      timerBot = Timer.periodic(Duration(seconds: 1), (_) {
        _handleTickRight();
      });
    }
  }

  _handleTickLeft() {
    if (isTopActive) {
      setState(() {
        if (secsTop == 0) {
          timerTop.cancel();
          timerBot.cancel();
          _showDialogTimesOver(TOP);
        } else {
          secsTop = secsTop - 1;
        }
      });
    }
  }

  _handleTickRight() {
    if (isBotActive) {
      setState(() {
        if (secsBot == 0) {
          timerTop.cancel();
          timerBot.cancel();
          _showDialogTimesOver(BOT);
        } else {
          secsBot = secsBot - 1;
        }
      });
    }
  }

  /// Player right pressed its button. Player left time is counting.
  void _triggerPlayerTop() {
    if (isTopActive || (!isTopActive && !isBotActive)) {
      isBotActive = true;
      isTopActive = false;

      setState(() {});
    }
  }

  /// Player left pressed its button. Player right time is counting.
  void _triggerPlayerBot() {
    if (isBotActive || (!isBotActive && !isTopActive)) {
      isTopActive = true;
      isBotActive = false;

      setState(() {});
    }
  }

  /// Returns whether the game started or not.
  _hasStarted() => isBotActive == true || isTopActive == true;

  _restart() {
    print('$_TAG: Restarting...');
    _init();
  }

  _showDialogTimesOver(int who) {
    String ff = 'SF';
    String content = who == TOP
        ? 'Player TOP ran out of time.'
        : 'Player BOT ran out of time.';

    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                'Time is over',
                style: TextStyle(fontSize: 22),
              ),
              content: Text(
                content,
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                // RestartButton(fun: _restart),
                // ChangeSettingsButton(),
                FlatButton(
                  child: Text(
                    'Reset clocks',
                    style: buttonStyle(),
                  ),
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    _restart();
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'Change settings',
                    style: buttonStyle(),
                  ),
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, InitialScreen.routeName);
                  },
                ),
              ],
            ));
  }

  @override
  void dispose() {
    if (timerTop != null) timerTop.cancel();
    if (timerBot != null) timerBot.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initTimersIfNeeded();

    _showDialogOptions() {
      var whichClockWasRunning = isTopActive ? TOP : isBotActive ? BOT : NONE;

      isTopActive = false;
      isBotActive = false;

      _resumeDialog() {
        if (whichClockWasRunning == TOP) {
          isTopActive = true;
        } else if (whichClockWasRunning == BOT) {
          isBotActive = true;
        }
        Navigator.pop(context);
      }

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            'Pause',
            // style: GoogleFonts.karla(fontSize: 22),
            style: TextStyle(
              fontSize: 22,
              // fontFamily: 'SF_Pro'),
            ),
          ),
          // TextStyle(fontSize: 22)),
          content: Text(
            'Both clocks are paused.',
            style: TextStyle(
              fontSize: 18,
              // fontFamily: 'SF_Pro'),
              // style: GoogleFonts.ubuntu(fontSize: 18),
              // TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            RestartButton(fun: _restart),
            ChangeSettingsButton(),
            ResumeButton(fun: _resumeDialog),
          ],
        ),
      );
    }

    Future<bool> _onWillPop() async {
      String ff = 'SF';

      return (await showCupertinoDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(
                'Confirmation',
                style: TextStyle(
                  fontFamily: ff,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: Text(
                  'Do you want to exit the app?',
                  style: TextStyle(
                    fontFamily: ff,
                    fontSize: 18,
                  ),
                ),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontFamily: ff,
                      fontSize: 18,
                    ),
                  ),
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: ff,
                      color: Color(0xFFFF453A),
                      fontSize: 18,
                    ),
                  ),
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => Navigator.of(context).pop(true),
                )
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      // Handles onBackPressed
      onWillPop: () => _onWillPop(),
      child: GestureDetector(
        onLongPress: () => _showDialogOptions(),
        child: Scaffold(
          body: Column(
            children: [
              PlayerSection(
                fun: _triggerPlayerTop,
                isActive: !_hasStarted() ? true : isTopActive,
                seconds: secsTop,
                gameSettings: widget.gameSettings,
                isPlayerOne: false,
              ),
              Separator(),
              PlayerSection(
                fun: _triggerPlayerBot,
                isActive: !_hasStarted() ? true : isBotActive,
                seconds: secsBot,
                gameSettings: widget.gameSettings,
                isPlayerOne: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
