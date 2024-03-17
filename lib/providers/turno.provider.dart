import 'package:flutter/foundation.dart';

class TurnoProvider with ChangeNotifier {
  int _indexMenu = 0;

  int get indexMenu => _indexMenu;

  void changeIndex(int newIndex) {
    _indexMenu = newIndex;
    notifyListeners();
  }
}
