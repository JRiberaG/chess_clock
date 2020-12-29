import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
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

  // bool isPressed;
  // int secondsPassed = 0;

  @override
  Widget build(BuildContext context) {
    _initTimersIfNeeded();

    return GestureDetector(
      // onLongPressStart: (_) async {
      //   isPressed = true;
      //   do {
      //     print('Long pressing');
      //     await Future.delayed(Duration(milliseconds: 500));
      //     secondsPassed++;
      //   } while (isPressed);
      // },
      // onLongPressEnd: (_) => setState(() {
      //   print('Seconds passed: $secondsPassed');
      //   if (secondsPassed >= 2) {
      //     _restart();
      //   }
      //   isPressed = false;
      //   secondsPassed = 0;
      // }),
      onLongPress: () {
        _restart();
      },
      child: Scaffold(
        body: Column(
          children: [
            PlayerSection(
              fun: _triggerPlayerTop,
              isActive: !_hasStarted() ? true : isTopActive,
              seconds: secsTop,
              gameSettings: widget.gameSettings,
              playerOne: false,
            ),
            Separator(),
            PlayerSection(
              fun: _triggerPlayerBot,
              isActive: !_hasStarted() ? true : isBotActive,
              seconds: secsBot,
              gameSettings: widget.gameSettings,
              playerOne: true,
            ),
          ],
        ),
      ),
    );
  }
}
