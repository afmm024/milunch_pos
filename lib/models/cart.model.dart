class Cart {
  String name;
  String image;
  int quantity;
  int price;
  String sku;

  Cart(
      {required this.name,
      required this.image,
      required this.quantity,
      required this.price,
      required this.sku
      });
     Map<String, dynamic> toJson() {
    return {
      "name": name,
      "imagen": image,
      "quantity": quantity,
      "price": price,
      "sku": sku,
    };
  }
}
