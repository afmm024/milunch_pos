import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:milunch_pos/pages/lock.dart';
import 'package:milunch_pos/pages/main.dart';
import 'package:provider/provider.dart';
import 'package:milunch_pos/providers/general.provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GeneralProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget with WindowListener {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Lunch POS',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AnimatedSplashScreen(
          animationDuration: Duration(seconds: 5),
          splash: const CircleAvatar(
            backgroundImage: AssetImage('assets/logo/512.png'),
            radius: 50,
          ),
          nextScreen: const MainScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
