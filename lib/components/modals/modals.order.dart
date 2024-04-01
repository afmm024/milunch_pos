import 'package:flutter/material.dart';

class OrderDialog extends StatelessWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hello there',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text(
              'This is a dialog. It can transition in from the top, bottom, left, or right. The size is also animated.'),
        ],
      ),
    );
  }
}