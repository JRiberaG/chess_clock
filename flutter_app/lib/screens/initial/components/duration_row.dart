import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/initial/components/header_field.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:flutter_app/utils/utils.dart';

class DurationRow extends StatefulWidget {
  final Duration duration;
  final Function(Duration) setDuration;

  const DurationRow({Key key, this.duration, this.setDuration})
      : super(key: key);

  @override
  _DurationRowState createState() => _DurationRowState();
}

class _DurationRowState extends State<DurationRow> {
  List<String> options = List();
  List<Duration> durations = [
    Duration(minutes: 2),
    Duration(minutes: 5),
    Duration(minutes: 30),
    Duration(minutes: 90),
  ];

  @override
  Widget build(BuildContext context) {
    _fillOptionsList();

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
                isSelected: _getSelectedList(),
                onPressed: (index) => _setDuration(index),
                borderRadius: BorderRadius.circular(10),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Duration durationSelected) {
    Duration newDuration = durationSelected;

    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: ScreenSize.h / 3,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                initialTimerDuration: durationSelected,
                onTimerDurationChanged: (duration) => newDuration = duration,
              ),
            )).whenComplete(() => widget.setDuration(newDuration));
  }

  List<bool> _getSelectedList() {
    List<bool> list = List();
    int minutes = widget.duration.inMinutes;

    switch (minutes) {
      case 2:
        list = [true, false, false, false, false];
        break;
      case 5:
        list = [false, true, false, false, false];
        break;
      case 30:
        list = [false, false, true, false, false];
        break;
      case 90:
        list = [false, false, false, true, false];
        break;
      default:
        list = [false, false, false, false, true];
        break;
    }

    return list;
  }

  _setDuration(int index) {
    if (index == 4) {
      _showBottomSheet(context, widget.duration);
    } else {
      Duration duration;
      switch (index) {
        case 0:
          duration = durations[0];
          break;
        case 1:
          duration = durations[1];
          break;
        case 2:
          duration = durations[2];
          break;
        default:
          duration = durations[3];
          break;
      }

      widget.setDuration(duration);
    }
  }

  _fillOptionsList() {
    options = List();
    for (var item in durations) options.add(formatDuration(item));
    int min = widget.duration.inMinutes;
    if (min != 2 && min != 5 && min != 30 && min != 90) {
      options.add(formatDuration(widget.duration));
    } else {
      options.add('Custom');
    }
  }
}
