import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/components/products/product.item.dart';
import 'package:milunch_pos/models/cart.model.dart';
import 'package:milunch_pos/providers/data.controller.dart';
import 'package:milunch_pos/providers/order.controller.dart';
import 'package:milunch_pos/utilities/dialogs.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final controller = Get.put(Data());
  final OrderController controllerOrder = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return GetX<Data>(
        builder: (_) => BarcodeKeyboardListener(
            child: ResponsiveGridList(
                desiredItemWidth: 180,
                squareCells: true,
                minSpacing: 10,
                children: controller.productsList.map((product) {
                  return CardItem(
                      image: 'assets/logo/128.png',
                      title: product.name,
                      price: product.product_type['price_sell'].toString(),
                      item: product.product_type['stock'].toString(),
                      sku: product.sku,
                      context: context);
                }).toList()),
            onBarcodeScanned: (barcode) {
              debugPrint(barcode);
              if (barcode == "0") {
                CustomSnackBar(
                  context,
                  const Text("El codigo de barras no es válido"),
                );
              } else {
                final product = controller.productsList
                    .firstWhere((element) => element.codebar == barcode);
                Cart itemCart = Cart(
                    image: 'assets/logo/128.png',
                    name: product.name,
                    price: int.parse(
                        product.product_type['price_sell'].toString()),
                    quantity: 1,
                    sku: product.sku);
                controllerOrder.addItem(itemCart);
              }
            }));
  }
}
