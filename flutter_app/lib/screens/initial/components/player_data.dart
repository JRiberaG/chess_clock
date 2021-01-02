import 'package:flutter/material.dart';
import 'package:flutter_app/models/providers/game_settings_provider.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:provider/provider.dart';

class PlayerData extends StatelessWidget {
  final bool isPlayerOne;

  const PlayerData({this.isPlayerOne});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameSettingsProvider>(context);

    int index = isPlayerOne ? 0 : 1;

    var name = provider.playerSettings[index].name;
    return Column(
      children: [
        name != null && name.isNotEmpty ? Text(name) : Container(),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: ScreenSize.w / 8,
          width: ScreenSize.w / 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey[800], width: 0.35),
            color:
                Color(provider.playerSettings[index].colorHex ?? DEFAULT_COLOR),
          ),
        ),
      ],
    );
  }
}
