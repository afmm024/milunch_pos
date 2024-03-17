 import 'package:mongo_dart/mongo_dart.dart';

class Categories {
      ObjectId? id;
      String name;
      bool status;

      Categories({
        this.id,
        required this.name,
        required this.status,
      });
      Map<dynamic, dynamic> toJson() {
        return {
          "name": name,
          "status": status,
        };
      }

      factory Categories.fromJson(Map<dynamic, dynamic> json) {
        return Categories(
          id: json['_id'],
          name: json['name'],
          status: json['status'],
        );
      }
    }