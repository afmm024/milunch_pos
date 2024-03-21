
import 'package:milunch_pos/models/products.model.dart';
import 'package:milunch_pos/models/response.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';

class ProductsService {
  static Future<Response> getProductsList() async {
    try {
      var products = await MongoDatabase.products
          .find()
          .map((json) => Products.fromJson(json))
          .toList();

      return Response(data: products, status: true, message: '');
    } catch (e) {
      return Response(data: [], status: false, message: e.toString());
    }
  }


}
