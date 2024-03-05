import 'package:flutter/foundation.dart';
import 'package:milunch_pos/database/database.dart';

class TurnoProvider with ChangeNotifier {
  int _indexMenu = 0;

  int get indexMenu => _indexMenu;

  void changeIndex(int newIndex) {
    _indexMenu = newIndex;
    notifyListeners();
  }
}
