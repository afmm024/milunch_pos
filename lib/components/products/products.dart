import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:milunch_pos/models/cart.model.dart';
import 'package:milunch_pos/providers/cart.provider.dart';
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
    if(context.mounted) {
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
                      return _item(
                          image: 'items/1.png',
                          title: product.name,
                          price: product.product_type['price_sell'].toString(),
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

  Widget _item(
      {required String image,
      required String title,
      required String price,
      required String item,
      required String sku,
      required BuildContext context}) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'es_CO', name: 'COP', decimalDigits: 0);
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('assets/' + image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currencyFormatter.format(int.parse(price)).toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: item),
                    const WidgetSpan(
                        child:
                            Icon(Icons.check, size: 18, color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8.0,
            children: <Widget>[
              FilledButton(onPressed: () {}, child: const Text('Express')),
              ElevatedButton(
                  onPressed: () {
                    Cart item = Cart(
                        image: image,
                        name: title,
                        price: int.parse(price),
                        quantity: 1,
                        sku: sku);
                    context.read<CartProvider>().putItem(item);
                  },
                  child: const Text('Carrito'))
            ],
          ),
        ],
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
