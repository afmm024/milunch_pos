import 'package:flutter/foundation.dart';
import 'package:milunch_pos/models/products.model.dart';

class Productsprovider with ChangeNotifier {
  late List<Products> _products = [];

  List<Products> get products => _products;

  void putProducts(List<Products> productslist){
    _products = productslist;
    notifyListeners();
  }

}
