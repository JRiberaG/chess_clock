import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/screens/initial/components/header_field.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:flutter_app/utils/utils.dart';

class OrientationRow extends StatefulWidget {
  final Duration duration;
  final int orientation;
  final Function(int) setOrientation;

  const OrientationRow(
      {Key key, this.orientation, this.setOrientation, this.duration})
      : super(key: key);

  @override
  _OrientationRowState createState() => _OrientationRowState();
}

class _OrientationRowState extends State<OrientationRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SEPARATOR_PADDING,
      child: Column(
        children: [
          HeaderField(title: 'Orientation'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => widget.setOrientation(LEFT),
                child: Column(
                  children: [
                    OrientationFigure(
                      duration: widget.duration,
                      orientation: LEFT,
                      selected: widget.orientation == LEFT,
                    ),
                    Radio(
                      value: LEFT,
                      groupValue: widget.orientation,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => widget.setOrientation(RIGHT),
                child: Column(
                  children: [
                    OrientationFigure(
                      duration: widget.duration,
                      orientation: RIGHT,
                      selected: widget.orientation == RIGHT,
                    ),
                    Radio(
                      value: RIGHT,
                      groupValue: widget.orientation,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrientationFigure extends StatelessWidget {
  final int orientation;
  final Duration duration;
  final bool selected;

  const OrientationFigure(
      {Key key, this.orientation, this.duration, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.w / 3,
      height: ScreenSize.h / 3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selected ? Colors.brown[100] : Color(0xFFE7DEDA),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 50,
            child: Container(
              width: double.infinity,
              child: RotatedBox(
                quarterTurns: orientation == LEFT ? 3 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDuration(duration),
                      style: TextStyle(
                        fontSize: ScreenSize.h / 35,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: Container(color: Colors.white)),
          Expanded(
            flex: 50,
            child: Container(
              width: double.infinity,
              child: RotatedBox(
                quarterTurns: orientation == LEFT ? 3 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDuration(duration),
                      style: TextStyle(
                        fontSize: ScreenSize.h / 35,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
