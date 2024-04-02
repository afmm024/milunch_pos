import 'package:milunch_pos/models/categories.model.dart';
import 'package:milunch_pos/models/order.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';

class OrderService {
  Future<List<Categories>> handleCategories() async {
    return await MongoDatabase.categories
          .find()
          .map((json) => Categories.fromJson(json))
          .toList();
  }

  Future<void> createOrder(Order order) async {
      await MongoDatabase.orders.insert(order.toJson());
  }

  
}
