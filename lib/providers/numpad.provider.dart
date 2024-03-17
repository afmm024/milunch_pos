import 'package:flutter/foundation.dart';

class NumberPadProvider with ChangeNotifier {
  var _newValue = '0';
  String get currentValue => _newValue;

  void appendedValue(String value) {
    _newValue = _newValue == '' ? value : _newValue + value;
    notifyListeners();
  }

  void removeValue() {
    if (_newValue != '0') {
      _newValue = _newValue.substring(0, _newValue.length - 1);
    }
    notifyListeners();
  }

  void clearCurrentValue() {
    _newValue = '0';
    notifyListeners();
  }
}