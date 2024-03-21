import 'package:flutter/material.dart';
import 'package:milunch_pos/models/cart.model.dart';
import 'package:milunch_pos/providers/cart.provider.dart';
import 'package:milunch_pos/utils/format.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String item;
  final String sku;
  final BuildContext context;

  CardItem(
      {required this.image,
      required this.title,
      required this.price,
      required this.item,
      required this.sku,
      required this.context});

  @override
  Widget build(BuildContext context) {
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
                FormatUtils.formatCurrency(int.parse(price)),
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
              TextButton(
                  onPressed: () {
                    Cart item = Cart(
                        image: image,
                        name: title,
                        price: int.parse(price),
                        quantity: 1,
                        sku: sku);
                    context.read<CartProvider>().putItem(item);
                  },
                  child: const Text('Añadir al carrito'))
            ],
          ),
        ],
      ),
    );
  }
}
