import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/components/categories/category.item.dart';
import 'package:milunch_pos/providers/data.controller.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final controller = Get.put(Data());

  @override
  Widget build(BuildContext context) {
    return GetX<Data>(
        builder: (_) => ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoriesList.length,
              itemBuilder: (context, index) {
                return Obx(() => CardHorizontalItem(
                  icon: 'icons/icon-noodles.png',
                  title: controller.categoriesList[index].name,
                  isActive: controller.selectedCategory == controller.categoriesList[index].name,
                  handleSelect: (value) => controller.handleCategory(value)
                ));
              },
            ));
  }
}
