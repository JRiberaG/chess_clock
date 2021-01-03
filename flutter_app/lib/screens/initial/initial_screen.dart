import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/game_settings.dart';
import 'package:flutter_app/models/providers/game_settings_provider.dart';
import 'package:flutter_app/models/providers/remember_provider.dart';
import 'package:flutter_app/screens/initial/components/duration_row.dart';
import 'package:flutter_app/screens/initial/components/header.dart';
import 'package:flutter_app/screens/initial/components/orientation_row.dart';
import 'package:flutter_app/screens/initial/components/player_data_row.dart';
import 'package:flutter_app/screens/initial/components/remember_tick.dart';
import 'package:flutter_app/screens/initial/components/start_button.dart';
import 'package:flutter_app/utils/preference_keys.dart';
import 'package:flutter_app/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _TAG = 'InitialScreen';

class InitialScreen extends StatelessWidget {
  static final routeName = '/';
  bool _firstLoad = true;
  SharedPreferences _preferences;

  @override
  Widget build(BuildContext context) {
    // Forces the device to display the app in Portrait mode.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ScreenSize().init(context);

    final provider = Provider.of<GameSettingsProvider>(context);
    final providerRemember = Provider.of<RememberProvider>(context);

    if (_firstLoad) {
      provider.clear();
      _firstLoad = false;
    }

    Future<void> _getPreferencesIfRequired() async {
      _preferences = await SharedPreferences.getInstance();
      bool prefRemember = _preferences.get(PreferenceKeys.saveChanges);
      if (prefRemember != null && prefRemember) {
        providerRemember.remember = true;
        String gameSettingsJson = _preferences.get(PreferenceKeys.gameSettings);
        if (gameSettingsJson != null) {
          GameSettings gsFromPreferences =
              GameSettings.fromMap(jsonDecode(gameSettingsJson));

          if (gsFromPreferences != null) {
            print(
                'GameSettings retrieved from preferences: ${jsonEncode(gsFromPreferences.toMap())}');
            provider.gameSettings = GameSettings(
                duration: gsFromPreferences.duration,
                orientation: gsFromPreferences.orientation,
                playerSettings: gsFromPreferences.playerSettings);
          }
        } else {
          provider.gameSettings = null;
        }
      } else {
        provider.gameSettings = null;
      }

      _firstLoad = false;
    }

    if (provider.gameSettings == null) _getPreferencesIfRequired();

    return Container(
      decoration: BoxDecoration(
        // color: const Color(0xFFbdb29b),
        color: Colors.brown[200],
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop)),
      ),
      // child: Center(child: Text('hello')),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: provider.gameSettings != null
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(),
                      PlayersRow(),
                      DurationRow(),
                      OrientationRow(),
                      RememberTick(),
                      StartButton(),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
