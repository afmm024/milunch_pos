import 'package:milunch_pos/models/cart.model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Order {
  ObjectId? id;
  String idOrder;
  String state;
  String products;
  ObjectId? clientsId;
  String employeId;
  String turnId;
  double totalAmount;
  String typePayment;
  String paymentMethod;
  DateTime created;

  Order(
      {this.id,
      this.clientsId,
      required this.idOrder,
      required this.state,
      required this.products,
      required this.totalAmount,
      required this.typePayment,
      required this.paymentMethod,
      required this.employeId,
      required this.turnId,
      required this.created});
  Map<String, dynamic> toJson() {
    return {
      "numOrder": idOrder,
      "state": state,
      "employeId": employeId,
      "turnId": turnId,
      "products": products,
      "totalAmount": totalAmount,
      "typePayment": typePayment,
      "paymentMethod": paymentMethod,
      "created": created,
    };
  }

  factory Order.fromJson(Map<dynamic, dynamic> json) {
    return Order(
      id: json['_id'],
      idOrder: json['numOrder'],
      state: json['state'],
      employeId: json['employeId'],
      turnId: json['turnId'],
      products: json['products'],
      totalAmount: json['totalAmount'],
      paymentMethod: json['paymentMethod'],
      typePayment: json['typePayment'],
      clientsId: json['_clientsId'],
      created: json['created'],
    );
  }
}
