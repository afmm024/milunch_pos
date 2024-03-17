import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:milunch_pos/database/constans.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static Db? _db;
  static final DbCollection categories = _db!.collection(CATEGORIES_COLLECTION);
  static final DbCollection products = _db!.collection(PRODUCTS_COLLECTION);

  static Future<Db> getConnection() async {
    int retryAttempts = 5;
    if (_db == null || !_db!.isConnected) {
      await close();
      var retry = 0;
      while (true) {
        try {
          retry++;
          var db = await Db.create(MONGO_URI);
          await db.open();
          _db = db;
          print('OK after "$retry" attempts');
          break;
        } catch (e) {
          if (retryAttempts < retry) {
            print('Exiting after "$retry" attempts');
            rethrow;
          }
          // each time waits a little bit more before re-trying
          await Future.delayed(Duration(milliseconds: 100 * retry));
        }
      }
    }
    return _db!;
  }

  static Future<void> close() async {
    try {
      await _db!.close();
    } catch (e) {
      log(e.toString());
    }
  }
}