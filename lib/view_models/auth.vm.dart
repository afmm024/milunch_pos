import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milunch_pos/screens/dashboard/main.dart';
import 'package:milunch_pos/services/users.service.dart';
import 'package:milunch_pos/utilities/dialogs.dart';
import 'package:milunch_pos/utilities/texts_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityViewModel {
  Future<void> handleLogin(BuildContext context, int pin) async {
    final userResponse = await UserService().login(pin);
    if (!context.mounted) return;
    if (!userResponse.status) {
      // ignore: use_build_context_synchronously
      CustomSnackBar(
        context,
        Text(userResponse.message),
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Texts.turneActive(), true);
      // Action Navigator
      Get.offAll(MainScreen());
    }
  }
}
