import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/components/actionbar/actionbar.dart';
import 'package:milunch_pos/components/navmenu/navmenu.dart';
import 'package:milunch_pos/providers/data.controller.dart';
import 'package:milunch_pos/screens/facuracion/factura.dart';
import 'package:milunch_pos/providers/general.controller.dart';
import 'package:milunch_pos/screens/turno/turno.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => new _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final controllerData = Get.put(Data());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ActionBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          tooltip: 'Sincronizar datos',
          onPressed: () => controllerData.handleAll(),
          child: const Icon(Icons.refresh, color: Colors.white, size: 28),
        ),
        body: Row(children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: FacturaScreen(),
            ),
          ),
        ]));
  }
}
