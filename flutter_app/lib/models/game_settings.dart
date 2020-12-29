import 'package:flutter_app/models/player_settings.dart';

class GameSettings {
  List<PlayerSettings> playerSettings;
  int orientation;
  Duration duration;

  GameSettings({this.playerSettings, this.orientation, this.duration});
}

const LEFT = 0;
const RIGHT = 1;
