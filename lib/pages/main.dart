import 'package:flutter/material.dart';
import 'package:milunch_pos/components/actionbar/actionbar.dart';
import 'package:milunch_pos/pages/factura.dart';
import 'package:milunch_pos/providers/general.provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  /// Constructs a [MainScreen]
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _pageView() {
      switch (context.watch<GeneralProvider>().indexMenu) {
        case 0:
          return const FacturaScreen();
        case 1:
          return Container();
        case 2:
          return Container();
        default:
          return const FacturaScreen();
      }
    }

    return Scaffold(
        appBar: ActionBar(),
        body: Row(children: <Widget>[
          NavigationRail(
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.monetization_on_outlined),
                  selectedIcon: Icon(Icons.monetization_on),
                  label: Text('Facturar'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.table_chart_outlined),
                  selectedIcon: Icon(Icons.table_chart),
                  label: Text('Inventario'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.access_time),
                  selectedIcon: Icon(Icons.access_time_filled),
                  label: Text('Turno'),
                ),
              ],
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (int index) {
                context.read<GeneralProvider>().changeIndex(index);
              },
              selectedIndex: context.watch<GeneralProvider>().indexMenu),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: _pageView(),
            ),
          ),
        ]));
  }
}
