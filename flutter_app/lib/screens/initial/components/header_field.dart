import 'package:flutter/material.dart';
import 'package:flutter_app/utils/screen_size.dart';

class HeaderField extends StatelessWidget {
  final String title;

  const HeaderField({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(title, style: TextStyle(fontSize: ScreenSize.h / 25)),
    );
  }
}
