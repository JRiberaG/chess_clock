import 'package:flutter/material.dart';
import 'package:flutter_app/models/player_settings.dart';
import 'package:flutter_app/utils/screen_size.dart';

class PlayerData extends StatefulWidget {
  final PlayerSettings settings;
  final bool isPlayer1;

  const PlayerData({
    this.settings,
    this.isPlayer1,
  });

  @override
  _PlayerDataState createState() => _PlayerDataState();
}

class _PlayerDataState extends State<PlayerData> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.settings.name;
    return Column(
      children: [
        name != null && name.isNotEmpty ? Text(name) : Container(),
        // Text(
        //   name != null && name.isNotEmpty
        //       ? name
        //       : widget.isPlayer1 ? 'Player 1' : 'Player 2',
        //   style: TextStyle(fontSize: 20),
        // ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: ScreenSize.w / 8,
          width: ScreenSize.w / 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey[800], width: 0.35),
            color: Color(widget.settings.colorHex),
          ),
        ),
      ],
    );
  }
}
