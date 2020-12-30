import 'package:flutter/material.dart';
import 'package:flutter_app/screens/initial/initial_screen.dart';
import 'package:flutter_app/utils/constants.dart';

class RestartButton extends StatelessWidget {
  final Function fun;
  final BuildContext ctx;

  const RestartButton({Key key, this.fun, this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FlatButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Reset clocks', style: buttonStyle()),
        ),
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          fun();
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ChangeSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FlatButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Change settings', style: buttonStyle()),
        ),
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, InitialScreen.routeName);
        },
      ),
    );
  }
}

class ResumeButton extends StatelessWidget {
  final Function fun;

  const ResumeButton({Key key, this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FlatButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Resume', style: buttonStyle()),
        ),
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () => fun(),
      ),
    );
  }
}
