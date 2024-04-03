import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/components/cart/cart.checkout.dart';
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
      constraints: BoxConstraints.tight(const Size(25, 25)),
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
      return ListTile(
        leading: Image.asset(item.image),
        title: Text(
          item.name,
          style: GoogleFonts.ubuntu(fontSize: 15),
        ),
        subtitle: Row(
          children: [
            countButton(index, controller.increase),
            Obx(() => Text(controller.cartProducts[index].quantity.toString())),
            countButton(index, controller.decrease, icon: Icons.remove)
          ],
        ),
        trailing: Text(
          FormatUtils.formatCurrency(item.price),
          style: GoogleFonts.ubuntu(color: Colors.red, fontSize: 14),
        ),
        horizontalTitleGap: 15.0,
      );
    }

    return Obx(() => Column(
          children: [
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
              ),
              padding: const EdgeInsets.all(15),
              itemCount: controller.cartProducts.length,
              itemBuilder: (_, index) {
                Cart item = controller.cartProducts[index];
                return listViewBody(item, index);
              },
            )),
            Obx(() => Visibility(
                  visible: controller.cartProducts.isNotEmpty,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  FormatUtils.formatCurrency(
                                      controller.price.value.toInt()),
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 22,
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(controller.itemCount.value.toString(),
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 16,
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
                              controller.handleOrderId();
                              showDialog(
                                context: context,
                                builder: (context) => FluidDialog(
                                  rootPage: FluidDialogPage(
                                    alignment: Alignment.center,
                                    builder: (context) => ModalCheckout()
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
