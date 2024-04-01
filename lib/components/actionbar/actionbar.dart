import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/providers/general.controller.dart';

class ActionBar extends StatelessWidget implements PreferredSizeWidget {
  const ActionBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(General());
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
                            color: controller.connectionStatus == ConnectivityResult.none ? Colors.orange : Colors.green,
                            action: Icon(
                              controller.connectionStatus == ConnectivityResult.none ? Icons.wifi_off_outlined : Icons.wifi_outlined,
                              color: Colors.white,
                            )),
                        actionItem(
                            color: Colors.red,
                            action: Text(
                              ' ${controller.username}',
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white, fontSize: 16),
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
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: InkWell(
        child: action,
        onLongPress: () {},
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
