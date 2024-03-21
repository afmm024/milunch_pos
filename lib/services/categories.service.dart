import 'dart:convert';
import 'package:milunch_pos/models/categories.model.dart';
import 'package:milunch_pos/models/response.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';

class CategoriesService {
  static Future<Response> getCategoriesList() async {

   try {
      var categorias= await MongoDatabase.categories
          .find()
          .map((json) => Categories.fromJson(json))
          .toList();

      return Response(data: categorias, status: true, message: '');
    } catch (e) {
      return Response(data: [], status: false, message: e.toString());
    }
  }
}
