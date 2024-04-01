import 'package:milunch_pos/models/categories.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';

class CategoriesService {
  Future<List<Categories>> handleCategories() async {
    return await MongoDatabase.categories
          .find()
          .map((json) => Categories.fromJson(json))
          .toList();
  }

  
}
