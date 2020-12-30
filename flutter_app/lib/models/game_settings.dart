import 'package:flutter_app/models/player_settings.dart';

class GameSettings {
  List<PlayerSettings> playerSettings;
  int orientation;
  Duration duration;

  GameSettings({this.playerSettings, this.orientation, this.duration});

  Map<String, dynamic> toMap() {
    return {
      'playerSettings': [
        {
          'name': playerSettings[0].name,
          'color': playerSettings[0].colorHex,
        },
        {
          'name': playerSettings[1].name,
          'color': playerSettings[1].colorHex,
        },
      ],
      'orientation': orientation,
      'duration': duration.inSeconds,
    };
  }

  static GameSettings fromMap(Map<String, dynamic> map) {
    List<PlayerSettings> getPlayerSettings() {
      List<PlayerSettings> list = List();
      for (int i = 0; i < 2; i++) {
        list.add(
          PlayerSettings(
            name: map['playerSettings'][i]['name'],
            colorHex: map['playerSettings'][i]['color'],
          ),
        );
      }
      return list;
    }

    return GameSettings(
        playerSettings: getPlayerSettings(),
        orientation: map['orientation'],
        duration: Duration(seconds: map['duration']));
  }
}

const LEFT = 0;
const RIGHT = 1;
