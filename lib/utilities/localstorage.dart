
import 'dart:convert';
import 'package:milunch_pos/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _userKey = 'user';

  static Future<void> saveAuthModel(User authModel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(authModel.toJson());
    await prefs.setString(_userKey, jsonString);
  }

  Future<User?> loadAuthModel() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString == null) return null;
    final jsonMap = json.decode(jsonString);
    return User.fromJson(jsonMap);
  }
}