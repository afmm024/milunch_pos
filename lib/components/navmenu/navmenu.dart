import 'package:flutter/material.dart';

class NavigationMenu {
  NavigationMenu();
  List<NavigationRailDestination> getMainMenu(BuildContext context) {
    return [
      const NavigationRailDestination(
          icon: Icon(Icons.monetization_on_outlined),
          selectedIcon: Icon(Icons.monetization_on),
          label: Text('Facturar')),
      const NavigationRailDestination(
        icon: Icon(Icons.table_chart_outlined),
        selectedIcon: Icon(Icons.table_chart),
        label: Text('Inventario'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.access_time),
        selectedIcon: Icon(Icons.access_time_filled),
        label: Text('Turno'),
      ),
    ];
  }
}
