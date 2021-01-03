import 'package:flutter/material.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/models/providers/game_settings_provider.dart';
import 'package:flutter_app/screens/initial/components/header_field.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

class OrientationRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameSettingsProvider>(context);

    return Padding(
      padding: SEPARATOR_PADDING,
      child: Column(
        children: [
          HeaderField(title: 'Orientation'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => provider.orientation = LEFT,
                child: Column(
                  children: [
                    OrientationFigure(
                      orientation: LEFT,
                      selected: provider.orientation == LEFT,
                    ),
                    Radio(
                      value: LEFT,
                      groupValue: provider.orientation,
                      onChanged: (value) => provider.orientation = LEFT,
                      activeColor: Col.selected,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => provider.orientation = RIGHT,
                child: Column(
                  children: [
                    OrientationFigure(
                      orientation: RIGHT,
                      selected: provider.orientation == RIGHT,
                    ),
                    Radio(
                      value: RIGHT,
                      groupValue: provider.orientation,
                      onChanged: (value) => provider.orientation = RIGHT,
                      activeColor: Col.selected,
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
  final bool selected;
  final int orientation;

  const OrientationFigure({Key key, this.orientation, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameSettingsProvider>(context);

    Expanded _getHalf() {
      return Expanded(
        flex: 50,
        child: Container(
          width: double.infinity,
          child: RotatedBox(
            quarterTurns: orientation == LEFT ? 3 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatDuration(provider.duration),
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
      );
    }

    return Container(
      width: ScreenSize.w / 3,
      height: ScreenSize.h / 3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selected ? Color(0xFFc9beb9) : Color(0xFFE7DEDA),
      ),
      child: Column(
        children: [
          _getHalf(),
          Expanded(flex: 1, child: Container(color: Colors.white)),
          _getHalf(),
        ],
      ),
    );
  }
}
