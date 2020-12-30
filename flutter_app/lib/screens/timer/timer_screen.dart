import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/screens/timer/components/dialog_buttons.dart';
import 'package:flutter_app/screens/timer/components/player_section.dart';

import 'components/separator.dart';

const String _TAG = 'TimerScreen';

class TimerScreen extends StatefulWidget {
  static final routeName = '/timer_screen';

  final GameSettings gameSettings;

  const TimerScreen({@required this.gameSettings});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // Timers
  Timer timerTop;
  Timer timerBot;

  // Flags to decide which timer counts down
  bool isBotActive;
  bool isTopActive;

  // Seconds left of each player
  int secsBot;
  int secsTop;

  // int _lastPlayerOn = NONE;

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
      timerTop = Timer.periodic(Duration(seconds: 1), (timer) {
        _handleTickLeft();
      });
    }
    if (timerBot == null) {
      timerBot = Timer.periodic(Duration(seconds: 1), (timer) {
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
          // TODO: 12/29/20 Display alarm, warning, toast or whatever
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
          // TODO: 12/29/20 Display alarm, warning, toast or whatever
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

  @override
  void dispose() {
    if (timerTop != null) timerTop.cancel();
    if (timerBot != null) timerBot.cancel();
    super.dispose();
  }

  // _pause() {
  //   print('Pausing');
  //   _lastPlayerOn = isTopActive ? TOP : isBotActive ? BOT : NONE;
  //
  //   isTopActive = false;
  //   isBotActive = false;
  // }

  // _resume() {
  //   print('Resuming');
  //   _lastPlayerOn = isTopActive ? TOP : isBotActive ? BOT : NONE;
  //
  //   if (_lastPlayerOn == TOP) {
  //     isTopActive = true;
  //   } else if (_lastPlayerOn == BOT) {
  //     isBotActive = true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    _initTimersIfNeeded();

    _showDialog() {
      var top = 0;
      var bot = 1;
      var none = -1;

      var whichClockWasRunning = isTopActive ? top : isBotActive ? bot : none;

      isTopActive = false;
      isBotActive = false;

      _resumeDialog() {
        if (whichClockWasRunning == top) {
          isTopActive = true;
        } else if (whichClockWasRunning == bot) {
          isBotActive = true;
        }
        Navigator.pop(context);
      }

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Pause', style: TextStyle(fontSize: 22)),
          content: Column(
            children: [
              Text(
                'Both clocks are paused.',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          actions: [
            RestartButton(fun: _restart),
            ChangeSettingsButton(),
            ResumeButton(fun: _resumeDialog),
          ],
        ),
      );
    }

    return GestureDetector(
      onLongPress: () => _showDialog(),
      // if (_isPaused) {
      //   print('Is paused -> showing dialog');
      //   _showDialog();
      // } else {
      //   print('Not paused -> pausing it');
      //   _pause();
      // }
      // _restart();
      // },
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
    );
  }
}
