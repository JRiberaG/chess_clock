import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/initial/header_field.dart';
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
  void _showBottomSheet(BuildContext context, Duration durationSelected) {
    Duration newDuration = durationSelected;

    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: ScreenSize.h / 3,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.ms,
                initialTimerDuration: durationSelected,
                onTimerDurationChanged: (duration) => newDuration = duration,
              ),
            )).whenComplete(() => widget.setDuration(newDuration));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context, widget.duration),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              HeaderField(title: 'Duration'),
              Text(
                formatDuration(widget.duration),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
