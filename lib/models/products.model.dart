import 'package:mongo_dart/mongo_dart.dart';

class Products {
  ObjectId? id;
  String name;
  String sku;
  Map<dynamic,dynamic> product_type;
  ObjectId? category_id;
  DateTime created;
  String codebar;

  Products(
      {this.id,
      this.category_id,
      required this.name,
      required this.sku,
      required this.product_type,
      required this.created,
      required this.codebar
      });
  Map<dynamic, dynamic> toJson() {
    return {
      "name": name,
      "sku": sku,
      "product_type": product_type,
      "created": created,
      "codebar": codebar
    };
  }

  factory Products.fromJson(Map<dynamic, dynamic> json) {
    return Products(
      id: json['_id'],
      name: json['name'],
      sku: json['sku'],
      product_type: json['product_type'],
      category_id: json['category_id'],
      created: json['created'],
      codebar: json['codebar']
    );
  }
}
