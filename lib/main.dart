import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:milunch_pos/components/logo/logo.dart';
import 'package:milunch_pos/core/data-source/firebase.dart';
import 'package:milunch_pos/pages/home.dart';
import 'package:milunch_pos/utils/constans.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(
      'es_US',
    );
    return MaterialApp(
      title: 'Mi Lunch POS',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: true,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String pageActive = 'Home';

  _pageView() {
    switch (pageActive) {
      case 'Facturar':
        return const HomePage();
      case 'Turnos':
        return Container();
      case 'Ventas':
        return Container();
      case 'Caja':
        return Container();
      case 'Ajustes':
        return Container();
      case 'Salir':
        return Container();
      default:
        return const HomePage();
    }
  }

  _setPage(String page) {
    setState(() {
      pageActive = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
            height: MediaQuery.of(context).size.height,
            child: _sideMenu(),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 24, right: 12),
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Color(0xfff2f2f2),
              ),
              child: _pageView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sideMenu() {
    return Column(children: [
      Logo(),
      const SizedBox(height: 30),
      Expanded(
        child: ListView(
          children: [
            _itemMenu(
              menu: 'Facturar',
              icon: Icons.point_of_sale,
            ),
            _itemMenu(
              menu: 'Turnos',
              icon: Icons.punch_clock,
            ),
            _itemMenu(
              menu: 'Ventas',
              icon: Icons.sell,
            ),
            _itemMenu(
              menu: 'Caja',
              icon: Icons.monetization_on,
            ),
            _itemMenu(
              menu: 'Ajustes',
              icon: Icons.settings,
            ),
            _itemMenu(
              menu: 'Salir',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _logo() {
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

  Widget _itemMenu({required String menu, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: GestureDetector(
        onTap: () => _setPage(menu),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: pageActive == menu
                    ? AppConstants.mlColor
                    : Colors.transparent,
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: pageActive == menu ? Colors.white : Colors.black,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    menu,
                    style: TextStyle(
                        color: pageActive == menu ? Colors.white : Colors.black,
                        fontSize: 10),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
