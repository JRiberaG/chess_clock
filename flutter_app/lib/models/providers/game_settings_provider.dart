import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/models/player_settings.dart';
import 'package:flutter_app/utils/constants.dart';

class GameSettingsProvider extends ChangeNotifier {
  GameSettings _gameSettings;

  // region GameSettings
  get gameSettings => _gameSettings;

  set gameSettings(GameSettings gameSettings) {
    this._gameSettings = gameSettings == null
        ? GameSettings(
            playerSettings: [
              PlayerSettings(colorHex: Col.blue),
              PlayerSettings(colorHex: Col.red),
            ],
            orientation: LEFT,
            duration: Duration(minutes: 2),
          )
        : gameSettings;
    notifyListeners();
  }
  // endregion

  // region Duration
  Duration get duration => _gameSettings.duration;

  set duration(Duration duration) {
    _gameSettings.duration = duration;
    notifyListeners();
  }
  // endregion

  // region PlayerSettings
  List<PlayerSettings> get playerSettings => _gameSettings.playerSettings;

  set playerSettings(List<PlayerSettings> playerSettings) {
    _gameSettings.playerSettings = playerSettings;
    notifyListeners();
  }
  // endregion

  // region Orientation
  int get orientation => _gameSettings.orientation;

  set orientation(int orientation) {
    _gameSettings.orientation = orientation;
    notifyListeners();
  }
  // endregion

  clear() => _gameSettings = null;
}
