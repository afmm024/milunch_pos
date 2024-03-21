import 'package:flutter/material.dart';
import 'package:milunch_pos/components/actionbar/actionbar.dart';
import 'package:milunch_pos/components/navmenu/navmenu.dart';
import 'package:milunch_pos/pages/factura.dart';
import 'package:milunch_pos/pages/inventory.dart';
import 'package:milunch_pos/providers/general.provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => new _MainScreen();
}

class _MainScreen extends State<MainScreen> {

  _pageView() {
    switch (context.watch<GeneralProvider>().indexMenu) {
      case 0:
        return FacturaScreen();
      case 1:
        return InventoryScreen();
      case 2:
        return Container();
      default:
        return  FacturaScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ActionBar(),
        body: Row(children: <Widget>[
          NavigationRail(
              destinations: <NavigationRailDestination>[
                ...NavigationMenu().getMainMenu(context)
              ],
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (int index) {
                context.read<GeneralProvider>().changeIndex(index);
              },
              backgroundColor: Colors.white,
              indicatorColor: Colors.red[200],
              selectedIndex: context.watch<GeneralProvider>().indexMenu),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: Colors.grey.shade200,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: _pageView(),
            ),
          ),
        ]));
  }
}
