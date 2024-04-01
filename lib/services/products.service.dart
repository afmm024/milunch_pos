
import 'package:milunch_pos/models/products.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';

class ProductsService {

  Future<List<Products>> handleProducts() async {
      return await MongoDatabase.products
          .find()
          .map((json) => Products.fromJson(json))
          .toList();
  }

  Future<List<Products>> handleProductsbyCategory(String category) async {
      return await MongoDatabase.products
          .find({'category_id': category})
          .map((json) => Products.fromJson(json))
          .toList();
  }


}
