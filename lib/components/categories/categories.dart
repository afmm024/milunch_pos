import 'package:flutter/material.dart';
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
      if(Provider.of<Categoriesprovider>(context).categories.isEmpty){
        getCategories();
      }
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
                      return _itemTab(
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

  Widget _itemTab(
      {required String icon, required String title, required bool isActive}) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 26),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: isActive
            ? Border.all(color: Colors.red, width: 3)
            : Border.all(color: Colors.grey.shade200, width: 3),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/' + icon),
            width: 38,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
