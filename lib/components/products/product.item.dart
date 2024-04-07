import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/models/cart.model.dart';
import 'package:milunch_pos/providers/order.controller.dart';
import 'package:milunch_pos/utils/format.dart';

final OrderController controller = Get.put(OrderController());

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
    return InkWell(
      onTap: () {
        Cart itemCart = Cart(
            image: image,
            name: title,
            price: int.parse(price),
            quantity: 1,
            sku: sku);
        controller.addItem(itemCart);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.ubuntu(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              FormatUtils.formatCurrency(int.parse(price)),
              style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
