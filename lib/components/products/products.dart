import 'package:flutter/material.dart';
import 'package:milunch_pos/components/products/product.item.dart';
import 'package:milunch_pos/providers/products.provider.dart';
import 'package:milunch_pos/services/products.service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProducts();
    });
  }

  Future<void> getProducts() async {
    final productsRequest = await ProductsService.getProductsList();
    if (!productsRequest.status) {
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
    return !_isError
        ? _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : RefreshIndicator(
                child: Consumer<Productsprovider>(
                  builder: (_, data, __) => ResponsiveGridList(
                      desiredItemWidth: 250,
                      minSpacing: 10,
                      children: data.products.map((product) {
                        return CardItem(
                            image: 'items/1.png',
                            title: product.name,
                            price:
                                product.product_type['price_sell'].toString(),
                            item: product.product_type['stock'].toString(),
                            sku: product.sku,
                            context: context);
                      }).toList()),
                ),
                onRefresh: () => getProducts())
        : const Center(
            child: Text(
              'Error cargando los productos',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
