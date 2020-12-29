import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/player_settings.dart';
import 'package:flutter_app/screens/initial/components/duration_row.dart';
import 'package:flutter_app/screens/initial/components/header.dart';
import 'package:flutter_app/screens/initial/components/orientation_row.dart';
import 'package:flutter_app/screens/initial/components/remember_tick.dart';
import 'package:flutter_app/screens/initial/components/start_button.dart';
import 'package:flutter_app/utils/screen_size.dart';

const String _TAG = 'InitialScreen';

class InitialScreen extends StatefulWidget {
  InitialScreen({Key key, this.title}) : super(key: key);
  static final routeName = '/';
  final String title;

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  Duration durationSelected = Duration(seconds: 0);
  int orientationSelected = LEFT;
  bool remember = true;
  List<PlayerSettings> playerSettings;

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

  @override
  void initState() {
    // TODO: 12/29/20  check if user has saved preferences and read them. If not, set it to the default values.
    playerSettings = List();
    playerSettings
        .add(PlayerSettings(name: 'Player 1', color: Colors.brown[300]));
    playerSettings
        .add(PlayerSettings(name: 'Player 2', color: Colors.orange[400]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    // Forces to display the app only in Portrait mode.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: ScreenSize.h / 25),
              PlayerDataRow(playerData: playerSettings),
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
      ),
    );
  }
}

class PlayerData extends StatefulWidget {
  final PlayerSettings settings;

  const PlayerData({Key key, this.settings}) : super(key: key);

  @override
  _PlayerDataState createState() => _PlayerDataState();
}

class _PlayerDataState extends State<PlayerData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${widget.settings.name ?? ''}'),
        Container(
          width: ScreenSize.h / 15,
          height: ScreenSize.h / 15,
          color: widget.settings.color ?? Colors.blue[100],
        )
      ],
    );
  }
}

class PlayerDataRow extends StatefulWidget {
  final List<PlayerSettings> playerData;

  const PlayerDataRow({Key key, this.playerData}) : super(key: key);

  @override
  _PlayerDataRowState createState() => _PlayerDataRowState();
}

class _PlayerDataRowState extends State<PlayerDataRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PlayerData(
          settings: widget.playerData[0],
        ),
        PlayerData(
          settings: widget.playerData[1],
        ),
      ],
    );
  }
}
