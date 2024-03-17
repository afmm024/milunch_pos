import 'package:flutter/material.dart';
import 'package:milunch_pos/providers/products.provider.dart';
import 'package:milunch_pos/services/products.service.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class DataGrid extends StatefulWidget {
  const DataGrid({Key? key}) : super(key: key);

  @override
  State<DataGrid> createState() => _DataGrid();
}

class _DataGrid extends State<DataGrid> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    if(context.mounted){
      if(Provider.of<Productsprovider>(context).products.isEmpty){
        getProducts();
      }
    }
  }

  Future<void> getProducts() async {
    final productsRequest = await ProductsService.getProductsList();
    if (!productsRequest.status) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(productsRequest.message)));
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      return;
    }
    context.read<Productsprovider>().putProducts(productsRequest.data);
    setState(() {
        _isLoading = false;
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
