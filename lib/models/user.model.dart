import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId? id;
  String username;
  int pin;
  bool status;
  String role;

  User(
      {this.id,
      required this.username,
      required this.pin,
      required this.status,
      required this.role
      });
  Map<dynamic, dynamic> toJson() {
    return {
      "username": username,
      "pin": pin,
      "status": status,
      "role": role
    };
  }

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      pin: json['pin'],
      status: json['status'],
      role: json['role']
    );
  }
}
