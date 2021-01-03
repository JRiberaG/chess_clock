import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/providers/remember_provider.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:provider/provider.dart';

class RememberTick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RememberProvider>(context);

    return Padding(
      padding: SEPARATOR_PADDING,
      child: GestureDetector(
        onTap: () => provider.remember = !provider.remember,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSwitch(
              value: provider.remember,
              onChanged: (value) => provider.remember = value,
              trackColor: Colors.grey[800],
              activeColor: Col.selected,
            ),
            SizedBox(width: 10),
            Text('Save settings',
                style: TextStyle(fontSize: 20, color: Colors.brown[50])),
          ],
        ),
      ),
    );
  }
}
