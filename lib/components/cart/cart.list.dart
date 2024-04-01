import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/components/modals/modals.order.dart';
import 'package:milunch_pos/models/cart.model.dart';
import 'package:milunch_pos/providers/order.controller.dart';
import 'package:milunch_pos/utils/format.dart';

final OrderController controller = Get.put(OrderController());

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  Widget countButton(int index, void Function(int index) counter,
      {IconData icon = Icons.add}) {
    return RawMaterialButton(
      onPressed: () {
        counter(index);
      },
      constraints: BoxConstraints.tight(Size(25, 25)),
      elevation: 0,
      fillColor: Colors.black,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: 15,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget listViewBody(Cart item, int index) {
      return Card(
          surfaceTintColor: Colors.red,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(30), // Image radius
                          child: Image.asset(item.image,
                              fit: BoxFit.cover, width: 60),
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.ubuntu(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        FormatUtils.formatCurrency(item.price),
                        style: GoogleFonts.ubuntu(color: Colors.red),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      countButton(index, controller.increase),
                      Obx(() => Text(
                          controller.cartProducts[index].quantity.toString())),
                      countButton(index, controller.decrease,
                          icon: Icons.remove)
                    ],
                  ),
                  const Spacer(),
                  RawMaterialButton(
                    onPressed: () {
                      controller.removeItem(index);
                    },
                    constraints: BoxConstraints.tight(Size(35, 35)),
                    elevation: 0,
                    fillColor: Colors.red,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    child: const Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ));
    }

    return Obx(() => Column(
          children: [
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: controller.cartProducts.length,
              itemBuilder: (_, index) {
                Cart item = controller.cartProducts[index];
                return listViewBody(item, index);
              },
            )),
            const Divider(),
            Obx(() => Visibility(
                  visible: controller.cartProducts.isNotEmpty,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  FormatUtils.formatCurrency(
                                      controller.price.value.toInt()),
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total items",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(controller.itemCount.value.toString(),
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FilledButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(80),
                                backgroundColor: Colors.green,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ))),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => FluidDialog(
                                  rootPage: FluidDialogPage(
                                    alignment: Alignment.center,
                                    builder: (context) => const OrderDialog(),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Generar pago',
                              style: TextStyle(fontSize: 24),
                            ),
                          )
                        ],
                      )),
                ))
          ],
        ));
  }
}
