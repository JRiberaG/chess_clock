import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/providers/game_settings_provider.dart';
import 'package:flutter_app/screens/initial/components/header_field.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DurationRow extends StatelessWidget {
  List<String> options = List();
  List<Duration> durations = [
    Duration(minutes: 2),
    Duration(minutes: 5),
    Duration(minutes: 30),
    Duration(minutes: 90),
  ];

  @override
  Widget build(BuildContext context) {
    final gameSettings = Provider.of<GameSettingsProvider>(context);

    _setToggleOptions(gameSettings);

    return Padding(
      padding: SEPARATOR_PADDING,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              HeaderField(title: 'Duration'),
              ToggleButtons(
                children: [
                  for (var item in options)
                    SizedBox(
                      width: ScreenSize.w / 6.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(item, textAlign: TextAlign.center),
                      ),
                    )
                ],
                fillColor: Colors.brown[100],
                color: Colors.grey[600],
                borderColor: Colors.brown[200],
                selectedBorderColor: Colors.brown[300],
                selectedColor: Colors.black,
                splashColor: Colors.transparent,
                isSelected: _getToggleSelected(gameSettings),
                onPressed: (index) => index == durations.length
                    ? _showBottomSheet(context,
                        gameSettings) // Custom pressed -> shows time picker
                    : gameSettings.duration = durations[index],
                borderRadius: BorderRadius.circular(10),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, GameSettingsProvider provider) {
    Duration newDuration = provider.duration;

    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: ScreenSize.h / 3,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                initialTimerDuration: provider.duration,
                onTimerDurationChanged: (duration) => newDuration = duration,
              ),
            )).whenComplete(() => provider.duration = newDuration);
  }

  List<bool> _getToggleSelected(GameSettingsProvider provider) {
    List<bool> list = List();

    int seconds = provider.duration.inSeconds;

    for (int i = 0; i < durations.length + 1; i++) {
      int indexSelected;
      switch (seconds) {
        case 2 * 60:
          indexSelected = 0;
          break;
        case 5 * 60:
          indexSelected = 1;
          break;
        case 30 * 60:
          indexSelected = 2;
          break;
        case 90 * 60:
          indexSelected = 3;
          break;
        default:
          indexSelected = 4;
          break;
      }

      list.add(indexSelected == i ? true : false);
    }

    return list;
  }

  _setToggleOptions(GameSettingsProvider provider) {
    options = List();
    for (var item in durations) options.add(formatDuration(item));
    int secs = provider.duration.inSeconds;
    if (secs != 2 * 60 &&
        secs != 5 * 60 &&
        secs != 30 * 60 &&
        secs != 90 * 60) {
      options.add(formatDuration(provider.duration));
    } else {
      options.add('Custom');
    }
  }
}
