import 'package:milunch_pos/models/cart.model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Order {
  ObjectId? id;
  String idOrder;
  String state;
  List<Cart> products;
  ObjectId? clientsId;
  String employeId;
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
      required this.created});
  Map<String, dynamic> toJson() {
    return {
      "idOrder": idOrder,
      "state": state,
      "employeId": employeId,
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
      idOrder: json['idOrder'],
      state: json['state'],
      employeId: json['employeId'],
      products: json['products'],
      totalAmount: json['totalAmount'],
      paymentMethod: json['paymentMethod'],
      typePayment: json['typePayment'],
      clientsId: json['_clientsId'],
      created: json['created'],
    );
  }
}

 enum Payment { nequi, daviplata, efectivo }
