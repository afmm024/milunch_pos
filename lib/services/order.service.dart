import 'package:flutter/foundation.dart';
import 'package:milunch_pos/models/order.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';

class OrderService {
  Future<void> createOrder(Order order) async {
    try {
      await MongoDatabase.orders.insert(order.toJson());
      final paramData = await getOrderQueue();
      String incrementOrder = (int.parse(paramData!['value']) + 1).toString();
      await MongoDatabase.params.findAndModify(
          query: {'type': 'order_queue'},
          update: {'value': incrementOrder, 'type': 'order_queue'});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<Map<String, dynamic>?> getOrderQueue() async {
    return await MongoDatabase.params.findOne({'type': 'order_queue'});
  }

  Future<List<Order>> getOrders() async {
    return await MongoDatabase.orders
        .find()
        .map((json) => Order.fromJson(json))
        .toList();
  }
}