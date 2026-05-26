import 'package:flutter/foundation.dart';

class PulseController extends ChangeNotifier {
  bool _enabled = true;

  bool get enabled => _enabled;

  void toggle() {
    _enabled = !_enabled;
    notifyListeners();
  }
}
