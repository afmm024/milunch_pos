import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/models/cart.model.dart';

class OrderController extends GetxController {
  final cartProducts = <Cart>[].obs;
  final itemCount = 0.obs;
  final price = 0.0.obs;

  double get priceTotal => price.value;

  addItem(Cart itemCart) {
    debugPrint("Agregaron un item");
    var contain = cartProducts.where((item) => item.sku == itemCart.sku);
    if(contain.isEmpty){
       cartProducts.add(itemCart);
      cartProducts.refresh();
      countAllItems();
      calculatePrice();
    }
  }

  removeItem(int index){
     cartProducts.removeAt(index);
     cartProducts.refresh();
      countAllItems();
      calculatePrice();
  }

  countAllItems() {
    itemCount.value = 0;
    for (var element in cartProducts) {
      itemCount.value += element.quantity;
    }
  }

  calculatePrice() {
    price.value = 0.0;
    for (var element in cartProducts) {
      if (element.quantity > 0) {
        price.value = (element.price * element.quantity) + price.value;
      }
    }
  }

  void increase(int index) {
    cartProducts[index].quantity++;
    cartProducts.refresh();
    countAllItems();
    calculatePrice();
  }

  void decrease(int index) {
    if (cartProducts[index].quantity > 0) {
      cartProducts[index].quantity--;
      if(cartProducts[index].quantity == 0){
        cartProducts.removeAt(index);
      }
      cartProducts.refresh();
      countAllItems();
      calculatePrice();
    }
  }

  void removeItems() {
    for (var item in cartProducts) {
      item.quantity = 0;
    }
    cartProducts.refresh();
    itemCount.value = 0;
    calculatePrice();
  }

  
}
