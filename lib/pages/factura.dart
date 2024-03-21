import 'package:flutter/material.dart';
import 'package:milunch_pos/components/cart/cart.main.dart';
import 'package:milunch_pos/components/categories/categories.dart';
import 'package:milunch_pos/components/products/products.dart';

class FacturaScreen extends StatefulWidget {

  FacturaScreen({Key? key}) : super(key: key);

  @override
  _FacturaScreen createState() => new _FacturaScreen();
}

class _FacturaScreen extends State<FacturaScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 14,
            child: Column(
              children: [
                Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: const CategoriesList()),
                const Expanded(child: ProductsList())
              ],
            ),
          ),
          Expanded(
              flex: 5,
              child: CartMain()),
        ],
      ),
    );
  }
}
