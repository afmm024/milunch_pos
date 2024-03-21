import 'package:flutter/material.dart';
import 'package:milunch_pos/components/categories/category.item.dart';
import 'package:milunch_pos/providers/categories.provider.dart';
import 'package:milunch_pos/services/categories.service.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    if (context.mounted){
      getCategories();
    }
  }

  Future<void> getCategories() async {
    final categoriesRequest = await CategoriesService.getCategoriesList();
    if (!categoriesRequest.status) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(categoriesRequest.message)));
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      return;
    }
    context.read<Categoriesprovider>().putCategories(categoriesRequest.data);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isError
        ? _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : RefreshIndicator(
                child: Consumer<Categoriesprovider>(
                  builder: (_, data, __) => ListView.builder(
                    itemCount: data.categories.length,
                    itemBuilder: (context, index) {
                      return CardHorizontalItem(
                        icon: 'icons/icon-noodles.png',
                        title: data.categories[index].name,
                        isActive: false,
                      );
                    },
                  ),
                ),
                onRefresh: () => getCategories())
        : const Center(
            child: Text(
              'Error cargando las categorias',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
  }
