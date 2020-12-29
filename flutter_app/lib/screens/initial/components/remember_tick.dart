import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RememberTick extends StatefulWidget {
  final bool remember;
  final Function(bool) setRemember;

  const RememberTick({Key key, this.remember, this.setRemember})
      : super(key: key);

  @override
  _RememberTickState createState() => _RememberTickState();
}

class _RememberTickState extends State<RememberTick> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () => widget.setRemember(!widget.remember),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSwitch(
              value: widget.remember,
              onChanged: (value) => widget.setRemember(value),
            ),
            SizedBox(width: 10),
            Text('Save settings', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
