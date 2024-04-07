import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:milunch_pos/models/response.model.dart';
import 'package:milunch_pos/models/user.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';
import 'package:milunch_pos/utilities/localstorage.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends ChangeNotifier {
  Future<Response> login(int pin) async {
    try {
      var query = where.eq('pin', pin);
      var user = await MongoDatabase.users.findOne(query);
      if (user == null) {
        return Response(
            data: [], status: false, message: 'No se encuentra el usuario');
      }
      final userModel = User.fromJson(user);
      if (!userModel.status) {
        return Response(data: [], status: false, message: 'Usuario inactivo');
      }
      DateTime now = DateTime.now();
      //String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
      ObjectId idTurn = ObjectId();
      final Map<String, dynamic> dataTurn = {
        "userId": userModel.id,
        "createdAt": now.toLocal().toString(),
        "closeAt": "",
        "status": "Active",
        "turnId": idTurn.toHexString()
      };
      await MongoDatabase.turns.insert(dataTurn);
      await LocalStorage.saveAuthModel(userModel);
      return Response(data: idTurn.toHexString(), status: true, message: '');
    } catch (e) {
      return Response(data: [], status: false, message: e.toString());
    }
  }

  Future<void> logout() async {
    DateTime now = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final turnId = prefs.getString('turnId');
    await MongoDatabase.turns.update(where.eq("turnId", turnId!),
        ModifierBuilder().set("closeAt", now.toLocal().toString()));
    await MongoDatabase.turns.update(where.eq("turnId", turnId),
        ModifierBuilder().set("status", "Finalized"));
  }
}
