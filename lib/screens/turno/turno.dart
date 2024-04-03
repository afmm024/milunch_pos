import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/providers/order.controller.dart';

final OrderController controller = Get.put(OrderController());

class TurnoScreen extends StatelessWidget {
  /// Constructs a [FacturaScreen]
  const TurnoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardKPI('Ordenes creadas', '100', Icons.show_chart),
            ],
          )
        ],
      )),
    );
  }

  Widget CardKPI(String title, String value, IconData icon) {
    return Container(
      height: 200,
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 3),
      ), // Adds a gradient background and rounded corners to the container
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title,
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Colors.black)), // Adds a title to the card
                  const Spacer(),
                  Icon(icon)
                ],
              ), // Adds a subtitle to the card
            ],
          ),
          Text(value,
              style: GoogleFonts.ubuntu(
                  fontSize: 30,
                  color: Colors.red)) // Adds a price to the bottom of the card
        ],
      ),
    );
  }
}
