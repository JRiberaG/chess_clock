import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/player_settings.dart';
import 'package:flutter_app/screens/initial/components/header_field.dart';
import 'package:flutter_app/screens/initial/components/player_data.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/screen_size.dart';

class PlayerDataRow extends StatefulWidget {
  final List<PlayerSettings> playerData;
  final Function(PlayerSettings, int) updatePlayersSettings;

  const PlayerDataRow({Key key, this.playerData, this.updatePlayersSettings})
      : super(key: key);

  @override
  _PlayerDataRowState createState() => _PlayerDataRowState();
}

class _PlayerDataRowState extends State<PlayerDataRow> {
  @override
  Widget build(BuildContext context) {
    _openBottomSheetModal(bool isPlayerOne) {
      TextEditingController _controllerText = TextEditingController();

      var radius = 50.0;
      var light = 50;
      var strong = 300;

      _focusedBorder() {
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            width: 1,
            color: Colors.brown[strong],
          ),
        );
      }

      _enabledBorder() {
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            width: 1,
            color: Colors.brown[light],
          ),
        );
      }

      _suffixIcon() {
        return IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.brown[500],
          ),
          onPressed: () => _controllerText.clear(),
        );
      }

      _inputDecoration() {
        return InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: 'Name',
          filled: true,
          fillColor: Colors.brown[light],
          enabledBorder: _enabledBorder(),
          focusedBorder: _focusedBorder(),
          suffixIcon: _suffixIcon(),
        );
      }

      var name =
          isPlayerOne ? widget.playerData[0].name : widget.playerData[1].name;
      if (name != null && name.isNotEmpty) _controllerText.text = name;

      List<int> colors = [
        Col.blue,
        Col.green,
        Col.red,
        Col.brown,
        Col.white,
        Col.black,
      ];

      int _selectedColor = widget.playerData[0].colorHex;

      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Container(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPlayerOne ? 'Player 1' : 'Player 2',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w300),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: ScreenSize.w / 1.75,
                        child: TextField(
                          controller: _controllerText,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          decoration: _inputDecoration(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15)
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var item in colors)
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedColor = item),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: ScreenSize.w / 8,
                                width: ScreenSize.w / 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Colors.grey[800], width: 0.35),
                                  color: Color(item),
                                ),
                                child: _selectedColor == item
                                    ? Icon(Icons.check)
                                    : Container(),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ).then((value) {
        var nameP1;
        if (_controllerText.text != null && _controllerText.text.isNotEmpty) {
          nameP1 = _controllerText.text;
        }

        var colorP1;
        if (_selectedColor != null) {
          colorP1 = _selectedColor;
        } else {
          colorP1 = widget.playerData[0].colorHex;
        }

        PlayerSettings updated =
            PlayerSettings(name: nameP1, colorHex: colorP1);

        var index = isPlayerOne ? 0 : 1;
        widget.updatePlayersSettings(updated, index);
      });
    }

    return Column(
      children: [
        HeaderField(title: 'Players'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => _openBottomSheetModal(true),
              child: PlayerData(
                settings: widget.playerData[0],
                isPlayer1: true,
              ),
            ),
            GestureDetector(
              onTap: () => _openBottomSheetModal(false),
              child: PlayerData(
                settings: widget.playerData[1],
                isPlayer1: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
