// ignore: file_names
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8), // Border radius
            child: ClipOval(child: Image.asset('assets/logo/128.png')),
          ),
        )
      ],
    );
  }
}
