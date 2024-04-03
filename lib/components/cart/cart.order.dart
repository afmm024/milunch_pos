import 'package:flutter/material.dart';
import 'package:milunch_pos/components/cart/cart.list.dart';

class CartOrder extends StatefulWidget {
  const CartOrder({super.key});
  @override
  State<CartOrder> createState() => _CartOrderState();
}

class _CartOrderState extends State<CartOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 3),
      ),
      child: const CartListView(),
    );
  }
}
