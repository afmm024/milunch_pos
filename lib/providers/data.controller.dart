import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/models/categories.model.dart';
import 'package:milunch_pos/models/products.model.dart';
import 'package:milunch_pos/services/categories.service.dart';
import 'package:milunch_pos/services/products.service.dart';

class Data extends GetxController {
  final _productsList = <Products>[].obs;
  final _categoriesList = <Categories>[].obs;
  final ProductsService products = ProductsService();
  final CategoriesService categories = CategoriesService();
  final _selectedCategory = "".obs;

  String get selectedCategory => _selectedCategory.value;

  List<Products> get productsList => _productsList;
  List<Categories> get categoriesList => _categoriesList;

   @override
  void onInit() {
    super.onInit();
    handleItemsList();
    handleCategories();
  }

  Future<void> handleItemsList() async {
    debugPrint("request list produts");
    _productsList.value  = await products.handleProducts();
  }

  Future<void> handleCategories() async {
    debugPrint("request list categories");
    _categoriesList.value = await categories.handleCategories();
  }

  Future<void> handleAll() async {
    debugPrint("request sync");
    await categories.handleCategories();
    await products.handleProducts();
  }

  Future<void> handleItemsbyCategory(String category) async{
    _productsList.value = await products.handleProductsbyCategory(category);
  }

  void handleCategory(String category) async{
    if(category == _selectedCategory.value){
      _selectedCategory.value = "";
      handleItemsList();
    }else{
      _selectedCategory.value = category;
      handleItemsbyCategory(category);
    }
    
    
  }
}
