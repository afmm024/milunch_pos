import 'dart:developer';
import 'package:milunch_pos/utilities/texts_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static Db? _db;
  static final DbCollection categories = _db!.collection(DatabaseEnv.categoriesCollect());
  static final DbCollection products = _db!.collection(DatabaseEnv.productCollect());
  static final DbCollection users = _db!.collection(DatabaseEnv.usersCollect());
  static final DbCollection orders = _db!.collection(DatabaseEnv.orderCollect());
  static final DbCollection params = _db!.collection(DatabaseEnv.paramsCollect());

  static Future<Db> getConnection() async {
    int retryAttempts = 5;
    if (_db == null || !_db!.isConnected) {
      await close();
      var retry = 0;
      while (true) {
        try {
          retry++;
          var db = await Db.create(DatabaseEnv.mongoUri());
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