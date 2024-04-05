import 'package:flutter/material.dart';

class NavigationMenu {
  NavigationMenu();
  List<NavigationRailDestination> getMainMenu(BuildContext context) {
    return [
      const NavigationRailDestination(
          icon: Icon(Icons.monetization_on_outlined),
          selectedIcon: Icon(Icons.monetization_on),
          label: Text('Facturar'))
    ];
  }
}
