import 'package:fluent_ui/fluent_ui.dart';
import 'package:milunch_pos/pages/lock.dart';
import 'package:milunch_pos/pages/turno.dart';
import 'package:provider/provider.dart';
import 'package:milunch_pos/pages/factura.dart';
import 'package:milunch_pos/providers/general.provider.dart';

class NavigationMenu {
  NavigationMenu();
  List<NavigationPaneItem> getMainMenu(BuildContext context) {
    return [
      PaneItem(
          key: const ValueKey('facturación'),
          icon: const Icon(FluentIcons.money),
          title: const Text('Facturar'),
          body: const LockScreen(),
          onTap: () => context.read<GeneralProvider>().changeIndex(0)),
      PaneItem(
          key: const ValueKey('inventario'),
          icon: const Icon(FluentIcons.table),
          title: const Text('Inventario'),
          body: const SizedBox.shrink(),
          onTap: () => context.read<GeneralProvider>().changeIndex(1)),
      PaneItem(
          key: const ValueKey('turnos'),
          icon: const Icon(FluentIcons.clock),
          title: const Text('Turnos'),
          body: const TurnoScreen(),
          onTap: () => context.read<GeneralProvider>().changeIndex(2)),
    ];
  }

  List<NavigationPaneItem> getFooterMenu(BuildContext context) {
    return [
      PaneItemSeparator(),
      PaneItem(
          key: const ValueKey('logout'),
          icon: const Icon(FluentIcons.sign_out),
          title: const Text('Salir'),
          body: const SizedBox.shrink(),
          onTap: () => debugPrint('Hago logout')),
    ];
  }
}
