import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  /// Constructs a [LaunchScreen]
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48, // Image radius
                backgroundImage: AssetImage('assets/logo/512.png'),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator()
            ]),
      ),
    );
  }
}
