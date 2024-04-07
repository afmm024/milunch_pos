import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/providers/auth.controller.dart';
import 'package:milunch_pos/providers/general.controller.dart';
import 'package:milunch_pos/providers/order.controller.dart';
import 'package:milunch_pos/screens/auth/login.screen.dart';
import 'package:milunch_pos/utils/format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionBar extends StatelessWidget implements PreferredSizeWidget {
  const ActionBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(General());
    final controllerOrder = Get.put(OrderController());
    final controllerAuth = Get.put(AuthenticationController());
    return GetX<General>(
        builder: (_) => AppBar(
              title: Text(
                'Mi Lunch POS',
                style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              elevation: 0,
              shape: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              backgroundColor: Colors.white,
              actions: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        actionItem(
                            color: controller.connectionStatus ==
                                    ConnectivityResult.none
                                ? Colors.orange
                                : Colors.green,
                            action: Icon(
                              controller.connectionStatus ==
                                      ConnectivityResult.none
                                  ? Icons.wifi_off_outlined
                                  : Icons.wifi_outlined,
                              color: Colors.white,
                            )),
                        actionItem(
                            color: Colors.red,
                            action: InkWell(
                              child: Text(
                                ' ${controller.username}',
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onTap: () async => {
                                await controllerOrder.handleOrders(),
                                showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (context) => FluidDialog(
                                    rootPage: FluidDialogPage(
                                        alignment: Alignment.center,
                                        builder: (context) => Container(
                                              color: Colors.transparent,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.60,
                                              child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: CouponCard(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.60,
                                                      curvePosition: 180,
                                                      curveRadius: 30,
                                                      borderRadius: 10,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Colors.red,
                                                            Colors.red.shade700,
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ),
                                                      ),
                                                      firstChild: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'ORDENES CREADAS EN TURNO',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white54,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            controllerOrder
                                                                .orders.length
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 56,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      secondChild: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  'BASE DE TURNO',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white54,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FormatUtils
                                                                      .formatCurrency(
                                                                          150000),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  'TOTAL EFECTIVO VENTAS',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white54,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FormatUtils.formatCurrency(
                                                                      controllerOrder
                                                                          .handleEfectivoOrders()
                                                                          .toInt()),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  'TOTAL TRANSFERENCIA VENTAS',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white54,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FormatUtils.formatCurrency(
                                                                      controllerOrder
                                                                          .handleEfectivoTransferencias()
                                                                          .toInt()),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  'TOTAL EN VENTAS',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white54,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FormatUtils.formatCurrency(controllerOrder
                                                                          .handleEfectivoOrders()
                                                                          .toInt() +
                                                                      controllerOrder
                                                                          .handleEfectivoTransferencias()
                                                                          .toInt()),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  'TOTAL EN CAJA',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white54,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FormatUtils.formatCurrency(150000 +
                                                                      controllerOrder
                                                                          .handleEfectivoOrders()
                                                                          .toInt()),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                side:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                await controllerOrder
                                                                    .logoutTurn();
                                                                controllerAuth
                                                                    .signOut();
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  "CERRAR TURNO"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            )),
                                  ),
                                )
                              },
                            ))
                      ],
                    ) //Container
                    ),
              ],
            ));
  }

  Widget actionItem({
    required Color color,
    required Widget action,
  }) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: action,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
