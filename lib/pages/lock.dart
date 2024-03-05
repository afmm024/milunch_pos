import 'package:flutter/material.dart';
import 'package:milunch_pos/providers/general.provider.dart';
import 'package:provider/provider.dart';

class LockScreen extends StatelessWidget {
  /// Constructs a [LockScreen]
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        children: [
          const Expanded(
              child: Image(
            image: AssetImage('assets/images/alert.jpg'),
            fit: BoxFit.contain,
          )),
          Expanded(
              child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 20.0),
                  child: SizedBox()))
        ],
      )),
    );
  }
}
