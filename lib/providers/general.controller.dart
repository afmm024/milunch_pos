import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/utilities/localstorage.dart';

class General extends GetxController {
  final _indexMenu = 0.obs;
  final LocalStorage _localStorage = LocalStorage();
  final _username = 'Usuario'.obs;
  final _role = ''.obs;
  final _connectionStatus = (ConnectivityResult.none).obs;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  /// Getters
  int get indexMenu => _indexMenu.value;
  String get username => _username.value;
  String get role => _role.value;
  ConnectivityResult get connectionStatus => _connectionStatus.value;

  /// Override

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
          _connectionStatus.value = result[0];
        });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  /// Functions
  void loadUserData() async {
    final userData = await _localStorage.loadAuthModel();
    _username.value = userData?.username ?? "";
    _role.value = userData?.role ?? "EMPLOYE";
  }

  void changeMenu(index) {
    _indexMenu.value = index;
  }
}
