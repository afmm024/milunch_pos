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
  final controller = Get.put(General());
  final controllerData = Get.put(Data());

  _pageView(int index) {
    switch (index) {
      case 0:
        return FacturaScreen();
      case 1:
        return TurnoScreen();
      default:
        return FacturaScreen();
    }
  }

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
        body: GetX<General>(
            builder: (_) => Row(children: <Widget>[
                  NavigationRail(
                      groupAlignment: 0.0,
                      destinations: <NavigationRailDestination>[
                        ...NavigationMenu().getMainMenu(context)
                      ],
                      labelType: NavigationRailLabelType.all,
                      onDestinationSelected: (int index) {
                        controller.changeMenu(index);
                      },
                      backgroundColor: Colors.white,
                      indicatorColor: Colors.red[200],
                      selectedIndex: controller.indexMenu),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Colors.grey.shade200,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 12, right: 12, left: 12),
                      child: _pageView(controller.indexMenu),
                    ),
                  ),
                ])));
  }
}
