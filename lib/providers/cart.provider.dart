import 'package:flutter/foundation.dart';
import 'package:milunch_pos/models/cart.model.dart';

class CartProvider with ChangeNotifier {
  List<Cart> _cart = [];

   List<Cart> get cart {
    return _cart;
  }


  void putItem(Cart itemCart) {
    var contain = _cart.where((item) => item.sku == itemCart.sku);
    if (contain.isEmpty) {
      var cartClone = List<Cart>.from(_cart)..add(itemCart);
      _cart = cartClone;
      notifyListeners();
      
    }
  }

  void clearCart(){
    _cart.clear();
    notifyListeners();
  }

  void updateQtyItem(String sku, int qty) {
    if(qty < 1 ){
      _cart.removeWhere((item) => item.sku == sku);
    }else{
       _cart[_cart.indexWhere((item) => item.sku == sku)].quantity = qty;
    }
    notifyListeners();
  }
}
