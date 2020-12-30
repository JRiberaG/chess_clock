import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/models/player_settings.dart';
import 'package:flutter_app/screens/initial/components/duration_row.dart';
import 'package:flutter_app/screens/initial/components/header.dart';
import 'package:flutter_app/screens/initial/components/orientation_row.dart';
import 'package:flutter_app/screens/initial/components/player_data_row.dart';
import 'package:flutter_app/screens/initial/components/remember_tick.dart';
import 'package:flutter_app/screens/initial/components/start_button.dart';
import 'package:flutter_app/utils/preference_keys.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _TAG = 'InitialScreen';

class InitialScreen extends StatefulWidget {
  InitialScreen({Key key, this.title}) : super(key: key);
  static final routeName = '/';
  final String title;

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  SharedPreferences _preferences;
  Duration durationSelected = Duration(seconds: 120);
  int orientationSelected = LEFT;
  bool remember = false;
  List<PlayerSettings> playerSettings;

  bool _loaded = false;

  _updateDuration(duration) {
    setState(() {
      durationSelected = duration;
    });
  }

  _updateOrientation(orientation) {
    setState(() {
      orientationSelected = orientation;
    });
  }

  _updateRemember(value) {
    setState(() => remember = value);
  }

  _updatePlayerSettings(value, index) {
    setState(() => playerSettings[index] = value);
  }

  Future<void> _getPreferencesIfRequired() async {
    _preferences = await SharedPreferences.getInstance();
    bool prefRemember = _preferences.get(PreferenceKeys.saveChanges);
    if (prefRemember != null && prefRemember) {
      remember = true;
      String gameSettingsJson = _preferences.get(PreferenceKeys.gameSettings);
      if (gameSettingsJson != null) {
        GameSettings gsFromPreferences =
            GameSettings.fromMap(jsonDecode(gameSettingsJson));

        if (gsFromPreferences != null) {
          print(
              'GameSettings retrieved from preferences: ${jsonEncode(gsFromPreferences.toMap())}');
          durationSelected = gsFromPreferences.duration;
          orientationSelected = gsFromPreferences.orientation;
          playerSettings = gsFromPreferences.playerSettings;
        }
      }
      _loaded = true;
    } else {
      _loaded = true;
    }
  }

  _init() async {
    playerSettings = List();
    playerSettings.add(PlayerSettings(colorHex: 0xFF8D6E63));
    playerSettings.add(PlayerSettings(colorHex: 0xFFFFA726));
    await _getPreferencesIfRequired();
    setState(() {});
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    // Forces the device to display the app in Portrait mode.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: _loaded == true
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(),
                    PlayerDataRow(
                      playerData: playerSettings,
                      updatePlayersSettings: _updatePlayerSettings,
                    ),
                    DurationRow(
                      duration: durationSelected,
                      setDuration: _updateDuration,
                    ),
                    OrientationRow(
                        duration: durationSelected,
                        orientation: orientationSelected,
                        setOrientation: _updateOrientation),
                    RememberTick(
                      remember: remember,
                      setRemember: _updateRemember,
                    ),
                    StartButton(
                      orientation: orientationSelected,
                      duration: durationSelected,
                      remember: remember,
                      playersSettings: playerSettings,
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
