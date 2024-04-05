import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/providers/auth.controller.dart';
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

final AuthenticationController controller = Get.put(AuthenticationController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // hide debug mode
      //'title:' On iOS this value cannot be used.
      // to use this titile in iOS so change in
      // CFBundleDisplayName from the app's Info.plist
      title: Texts.titleApp(),
      // 'Future' is function to set base root
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (controller.state == "Unauthenticated") {
            return LoginScreen();
          }

          if (controller.state == "Authenticated") {
            return MainScreen();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
