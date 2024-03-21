import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:milunch_pos/pages/main.dart';
import 'package:milunch_pos/providers/cart.provider.dart';
import 'package:milunch_pos/providers/categories.provider.dart';
import 'package:milunch_pos/providers/numpad.provider.dart';
import 'package:milunch_pos/providers/products.provider.dart';
import 'package:milunch_pos/services/mongo.service.dart';
import 'package:provider/provider.dart';
import 'package:milunch_pos/providers/general.provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MongoDatabase.getConnection();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GeneralProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => Productsprovider()),
      ChangeNotifierProvider(create: (_) => Categoriesprovider()),
      ChangeNotifierProvider(create: (_) => NumberPadProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget with WindowListener {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Lunch POS',
      theme: ThemeData(colorScheme: ColorScheme.light(primary: Colors.red)),
      home: AnimatedSplashScreen(
          animationDuration: Duration(seconds: 2),
          splash: const CircleAvatar(
            backgroundImage: AssetImage('assets/logo/256.png'),
            radius: 60,
          ),
          nextScreen: MainScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
