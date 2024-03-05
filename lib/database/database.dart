import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  MongoDatabase();
  static Db? db;
  static DbCollection turnos = db!.collection('turnos');
  static DbCollection users = db!.collection('users');

  static Future<void> connect() async {
    try {
      db = await Db.create(
          'mongodb+srv://munozmarinandresfelipe:P3FukYeZ4y37Mz2k@devcluster.1otn7gc.mongodb.net/?retryWrites=true&w=majority&appName=DevCluster');
      await db!.open();
      inspect(db);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> close() async {
    try {
      await db!.close();
    } catch (e) {
      log(e.toString());
    }
  }
}
