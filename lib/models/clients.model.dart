 import 'package:mongo_dart/mongo_dart.dart';

class Clients {
      ObjectId? id;
      String fullName;
      int document;
      String typeDocument;
      String email;
      String phoneNumber;
      String address;
 
      Clients({
        this.id,
        required this.fullName,
        required this.document,
        required this.typeDocument,
        required this.email,
        required this.address,
        required this.phoneNumber
      });
      Map<dynamic, dynamic> toJson() {
        return {
          "fullName": fullName,
          "document": document,
          "typeDocument": typeDocument,
          "email": email,
          "address": address,
          "phoneNumber": phoneNumber,
        };
      }

      factory Clients.fromJson(Map<dynamic, dynamic> json) {
        return Clients(
          id: json['_id'],
          fullName: json['fullName'],
          document: json['document'],
          typeDocument: json['typeDocument'],
          email: json['email'],
          address: json['address'],
          phoneNumber: json['phoneNumber'],
        );
      }
    }