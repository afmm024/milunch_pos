import 'package:flutter/foundation.dart';
import 'package:milunch_pos/models/categories.model.dart';

class Categoriesprovider with ChangeNotifier {
  late List<Categories> _categories = [];

  List<Categories> get categories => _categories;

  void putCategories(List<Categories> productslist){
    _categories = productslist;
    notifyListeners();
  }

}
