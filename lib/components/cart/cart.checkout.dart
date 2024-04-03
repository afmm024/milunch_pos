import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/providers/order.controller.dart';
import 'package:milunch_pos/utilities/texts_constants.dart';
import 'package:milunch_pos/utils/alerts.dart';
import 'package:milunch_pos/utils/format.dart';
import 'package:select_card/select_card.dart';

final OrderController controller = Get.put(OrderController());

class ModalCheckout extends StatefulWidget {
  @override
  _ModalCheckoutState createState() => _ModalCheckoutState();
}

class _ModalCheckoutState extends State<ModalCheckout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.30,
      child: Column(children: [
        Text(
          "Forma de pago",
          style: GoogleFonts.ubuntu(fontSize: 30),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
          child: Center(
            child: SelectGroupCard(context,
                titles: Texts.titles,
                ids: Texts.ids,
                imageSourceType: ImageSourceType.network,
                images: Texts.imagesFromNetwork,
                cardBackgroundColor: Colors.white,
                cardSelectedColor: Colors.red,
                radius: 5,
                titleTextColor: Colors.black, onTap: (id) {
              controller.changePaymentMethod(id);
            }),
          ),
        ),
        const Divider(),
        Obx(
          () => Visibility(
              visible: controller.paymentMethod.isNotEmpty,
              child: Column(
                children: [
                  Text(
                    "Información de pago",
                    style: GoogleFonts.ubuntu(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.ubuntu(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Obx(() => Text(
                          FormatUtils.formatCurrency(
                              controller.price.value.toInt()),
                          style: GoogleFonts.ubuntu(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dinero recibido",
                        style: GoogleFonts.ubuntu(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Obx(() => (controller.paymentMethod == "Nequi" ||
                              controller.paymentMethod == "Daviplata")
                          ? Text(
                              FormatUtils.formatCurrency(
                                  controller.price.value.toInt()),
                              style: GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight
                                      .bold)) // if part of Flutter if else
                          : SizedBox(
                              width: 150,
                              child: TextFormField(
                                  initialValue: controller.inputMoney,
                                  onChanged: (value) =>
                                      controller.handleInputMoney(value),
                                  textDirection: TextDirection.rtl,
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder())))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.paymentMethod == "Mixto",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dinero en transferencia",
                            style: GoogleFonts.ubuntu(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              FormatUtils.formatCurrency(
                                  controller.price.value.toInt() -
                                      int.parse(controller.inputMoney)),
                              style: GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Devolución",
                        style: GoogleFonts.ubuntu(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Obx(() => Text(
                          FormatUtils.formatCurrency(
                              controller.paymentMethod == "Efectivo"
                                  ? controller.price.value.toInt() -
                                      int.parse(controller.inputMoney)
                                  : 0),
                          style: GoogleFonts.ubuntu(
                              fontSize: 20,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)))
                    ],
                  ),
                ],
              )),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
              "Orden # ${controller.orderId}",
              style:
                  GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
            ),),
            SizedBox(
              width: 150,
              child: FilledButton(
                
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: Colors.red,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ))),
                            onPressed: () {
                                if(controller.paymentMethod.isNotEmpty){
                                  if(controller.paymentMethod == "Efectivo" || controller.paymentMethod == "Mixto"){
                                    if(controller.inputMoney.isNotEmpty){
                                        controller.createOrder();
                                        AlertsUtils.showSnackBar(context, 'Se ha creado la orden correctamente');
                                        DialogNavigator.of(context).close();
                                    }
                                  }else{
                                    controller.createOrder();
                                    AlertsUtils.showSnackBar(context, 'Se ha creado la orden correctamente');
                                    DialogNavigator.of(context).close();
                                  }
                                }
                            },
                            child: Text(
                              'Crear orden',
                              style: GoogleFonts.ubuntu(),
                            ),
                          )
            )
          ],
        ),
      ]),
    );
  }
}
