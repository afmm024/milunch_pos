import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget implements PreferredSizeWidget {
  const ActionBar({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(
        'Mi Lunch POS',
        style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
      ),
      centerTitle: false,
      elevation: 0,
      shape: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      backgroundColor: Colors.white,
      actions: [
        Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: Tooltip(
              message: 'Conexión de servidor',
              child: IconButton(
                icon: const Icon(
                  Icons.wifi,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            )),
        Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: Tooltip(
              message: 'Estado de turno',
              child: IconButton(
                icon: const Icon(
                  Icons.timer_off_outlined,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ))
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
