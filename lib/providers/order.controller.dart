import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/models/cart.model.dart';
import 'package:milunch_pos/models/order.model.dart';
import 'package:milunch_pos/services/order.service.dart';
import 'package:milunch_pos/utilities/localstorage.dart';

class OrderController extends GetxController {

  final cartProducts = <Cart>[].obs;
  final itemCount = 0.obs;
  final price = 0.0.obs;
  final _paymentMehod = "".obs;
  final _inputMoney = "0".obs;
  final _orderId = "".obs;
  final OrderService orderService = OrderService();
  final LocalStorage storage = LocalStorage();

  double get priceTotal => price.value;
  String get paymentMethod => _paymentMehod.value;
  String get inputMoney => _inputMoney.value;
  String get orderId => _orderId.value;

  handleOrderId() async{
    final paramData = await orderService.getOrderQueue();
     _orderId.value = 'ML-POS-${paramData!['value']}';
  }

  handleOrders() async {
    final orders = await orderService.getOrders();
    return orders.length;
  }

  createOrder() async {
    final userAuth = await storage.loadAuthModel();
    Order orderData = Order(
      created: DateTime.now(),
      employeId: userAuth!.id.toString(),
      idOrder: orderId,
      paymentMethod: paymentMethod,
      products: jsonEncode(cartProducts.map((e) => e.toJson()).toList()),
      state: 'Active',
      totalAmount: priceTotal,
      turnId: 'idtruntest',
      typePayment: paymentMethod == "Nequi" || paymentMethod == "Daviplata" ? "Transferencia" : "Efectivo",
    );
    await orderService.createOrder(orderData);
    resetOrder();
  }

  resetOrder(){
    cartProducts.clear();
    itemCount.value = 0;
    price.value = 0.0;
    _paymentMehod.value = "";
    _inputMoney.value = "0";
    _orderId.value =  "";
  }

  changePaymentMethod(String id){
    _paymentMehod.value = id;
  }

  handleInputMoney(String input){
    if(input == ""){
      _inputMoney.value = "0";
    }else{
       _inputMoney.value = input;
    }
  }

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
