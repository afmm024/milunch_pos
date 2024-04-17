import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/providers/auth.controller.dart';
import 'package:milunch_pos/providers/cart.provider.dart';
import 'package:milunch_pos/providers/numpad.provider.dart';
import 'package:milunch_pos/screens/auth/login.screen.dart';
import 'package:milunch_pos/screens/dashboard/main.dart';
import 'package:milunch_pos/services/mongo.service.dart';
import 'package:milunch_pos/services/shared_preference/shared_preference.dart';
import 'package:milunch_pos/utilities/texts_constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart'; // default package

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.initialize();
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
    return OverlaySupport(
        child: MaterialApp(
            themeMode: ThemeMode.light,
            theme: ThemeData(
              primarySwatch: Colors.red,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            title: Texts.titleApp(),
            home: SafeArea(
              child: Scaffold(
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
            )));
  }
}
