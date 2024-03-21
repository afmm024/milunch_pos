import 'dart:developer';
import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:milunch_pos/components/numpad/numpad.dart';
import 'package:milunch_pos/models/cart.model.dart';
import 'package:milunch_pos/providers/cart.provider.dart';
import 'package:milunch_pos/providers/numpad.provider.dart';
import 'package:provider/provider.dart';

class CartMain extends StatefulWidget {
  const CartMain({super.key});
  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  final currencyFormatter =
      NumberFormat.currency(locale: 'es_CO', name: 'COP', decimalDigits: 0);

  String number = "0";

  final controller = GroupButtonController();

  int getTotalPrice(List<Cart> items) {
    int total = 0;
    for (var item in items) {
      total += item.quantity * item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (_, data, __) => Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 3),
              ),
              child: Column(
                children: [
                  _topMenu(
                    title: 'Orden N. 001',
                    subTitle: 'Vendedor: ',
                    action: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        data.cart.length > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => data.clearCart(),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  BarcodeKeyboardListener(
                      child: SizedBox(),
                      onBarcodeScanned: (barcode) {
                        debugPrint(barcode);
                      }),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: data.cart.length,
                      itemBuilder: (context, index) {
                        return _itemOrder(
                            image: data.cart[index].image,
                            title: data.cart[index].name,
                            qty: data.cart[index].quantity,
                            price: data.cart[index].price,
                            sku: data.cart[index].sku,
                            context: context);
                      },
                    ),
                  ),
                  data.cart.length > 0
                      ? Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white10,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sub Total',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      currencyFormatter
                                          .format(getTotalPrice(data.cart)),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  height: 2,
                                  width: double.infinity,
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    Text(
                                      currencyFormatter
                                          .format(getTotalPrice(data.cart)),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 80, //height of button
                                  width: MediaQuery.of(context).size.width *
                                      0.20, //width of button
                                  child: FilledButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              color: Colors.white,
                                              padding: const EdgeInsets.all(20),                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      Text(
                                                        currencyFormatter.format(
                                                            int.parse(Provider
                                                                    .of<NumberPadProvider>(
                                                                        context)
                                                                .currentValue)),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.green,
                                                            fontSize: 30),
                                                      ),
                                                      Text(
                                                          '- ${currencyFormatter.format(getTotalPrice(data.cart))}',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 20)),
                                                      getTotalPrice(data.cart) -
                                                                  int.parse(Provider.of<
                                                                              NumberPadProvider>(
                                                                          context)
                                                                      .currentValue) <
                                                              0
                                                          ? Text(
                                                              currencyFormatter.format(int.parse(
                                                                      Provider.of<NumberPadProvider>(
                                                                              context)
                                                                          .currentValue) -
                                                                  getTotalPrice(
                                                                      data.cart)),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .purple),
                                                            )
                                                          : SizedBox(),
                                                      NumberPad()
                                                    ],
                                                  )),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    height: double.infinity,
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  Expanded(
                                                      child: Center(
                                                    child: Column(
                                                      children: [
                                                        const Text("Seleccione el método de pago", style: TextStyle(color: Colors.red, fontSize: 18),),
                                                        const SizedBox(height: 5,),
                                                        GroupButton(
                                                          options: GroupButtonOptions(buttonHeight: 60, buttonWidth: 100),
                                                          controller:
                                                              controller,
                                                          buttons: const [
                                                            'Efectivo',
                                                            'Nequi',
                                                            'Daviplata'
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ));
                                        },
                                      );
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.money, size: 20),
                                        SizedBox(width: 6),
                                        Text('Cobrar')
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ));
  }

  Widget _itemOrder(
      {required String image,
      required String title,
      required int qty,
      required int price,
      required String sku,
      required BuildContext context}) {
    debugPrint(qty.toString());
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/' + image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  price.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          CustomizableCounter(
            borderColor: Colors.red,
            borderWidth: 1,
            borderRadius: 10,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            textSize: 15,
            showButtonText: false,
            count: qty.toDouble(),
            minCount: 0,
            maxCount: 10,
            incrementIcon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 15,
            ),
            decrementIcon: const Icon(
              Icons.remove,
              color: Colors.black,
              size: 15,
            ),
            onCountChange: (value) {
              debugPrint("Estoy en el counter change");
              debugPrint(value.toString());
              debugPrint(qty.toString());
              context.read<CartProvider>().updateQtyItem(sku, value.toInt());
            },
          ),
        ],
      ),
    );
  }

  Widget _topMenu({
    required String title,
    required String subTitle,
    required Widget action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subTitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
        Expanded(flex: 5, child: Container(width: double.infinity)),
        Expanded(flex: 1, child: action),
      ],
    );
  }
}
