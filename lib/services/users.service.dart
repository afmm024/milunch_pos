import 'package:flutter/material.dart';
import 'package:milunch_pos/models/response.model.dart';
import 'package:milunch_pos/models/user.model.dart';
import 'package:milunch_pos/services/mongo.service.dart';
import 'package:milunch_pos/utilities/localstorage.dart';
import 'package:mongo_dart/mongo_dart.dart';

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
      await LocalStorage.saveAuthModel(userModel);
      return Response(data: user, status: true, message: '');
    } catch (e) {
      return Response(data: [], status: false, message: e.toString());
    }
  }
}
