import 'package:flutter/foundation.dart';

class RememberProvider extends ChangeNotifier {
  bool _remember = false;

  bool get remember => _remember;
  set remember(bool remember) {
    this._remember = remember;
    notifyListeners();
  }
}
