import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/providers/cart.provider.dart';
import 'package:milunch_pos/providers/numpad.provider.dart';
import 'package:milunch_pos/screens/auth/login.screen.dart';
import 'package:milunch_pos/screens/dashboard/main.dart';
import 'package:milunch_pos/services/mongo.service.dart';
import 'package:milunch_pos/utilities/texts_constants.dart';
import 'package:milunch_pos/view_models/auth.vm.dart';
import 'package:provider/provider.dart'; // default package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MongoDatabase.getConnection();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => NumberPadProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          scaffoldBackgroundColor:
              const Color(0xFFEFEFEF)), // set static light mode
      debugShowCheckedModeBanner: false, // hide debug mode
      //'title:' On iOS this value cannot be used.
      // to use this titile in iOS so change in
      // CFBundleDisplayName from the app's Info.plist
      title: Texts.titleApp(),
      // 'Future' is function to set base root
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<bool>(
          future: SecurityViewModel.checkLogin(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return MainScreen();
              }
              return const LoginScreen();
            } else if (snapshot.hasError) {
              return const LoginScreen();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
