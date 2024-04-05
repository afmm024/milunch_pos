import 'package:get/get.dart';
import 'package:milunch_pos/utilities/texts_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  final _authenticationStateStream = "Unauthenticated".obs;

  String get state => _authenticationStateStream.value;

  @override
  void onInit() {
    getAuthenticatedUser();
    super.onInit();
  }

  void signIn() {
    _authenticationStateStream.value = "Authenticated";
  }

  void signOut() {
    _authenticationStateStream.value = "Unauthenticated";
  }

  void getAuthenticatedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool(Texts.turneActive()) ?? false;
    if (isAuth) {
      signIn();
    } else {
      signOut();
    }
  }
}
