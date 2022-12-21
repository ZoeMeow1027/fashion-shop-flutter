class CartHistoryItem {
  int id = 0;
  List<OrderItem> cartList = [];
  ShippingAddressItem shippingAddress = ShippingAddressItem();
  String paymentMethod = "CoD";
  double itemPrice = 0;
  double taxPrice = 0;
  double shipPrice = 0;
  double totalPrice = 0;
  DateTime? paidAt;
  DateTime? deliveredAt;
  DateTime? createdAt;

  CartHistoryItem.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['_id'].toString()) ?? 0;
    paymentMethod = json['paymentMethod'].toString();
    taxPrice = double.tryParse(json['taxPrice'].toString()) ?? 0;
    shipPrice = double.tryParse(json['shippingPrice'].toString()) ?? 0;
    totalPrice = double.tryParse(json['totalPrice'].toString()) ?? 0;
    paidAt = DateTime.tryParse(json['paidAt'].toString());
    deliveredAt = DateTime.tryParse(json['deliveredAt'].toString());
    createdAt = DateTime.tryParse(json['createAt'].toString());
    shippingAddress = ShippingAddressItem.fromJson(json['shippingAddress']);
    for (var orderItem in (json['orderItems'] as List<dynamic>)) {
      cartList.add(OrderItem.fromJson(orderItem as Map<String, dynamic>));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "orderItems":
          List.generate(cartList.length, (index) => cartList[index].toJson()),
      "shippingAddress": shippingAddress.toJson(),
      "paymentMethod": paymentMethod,
      "itemsPrice": itemPrice,
      "shippingPrice": shipPrice,
      "taxPrice": taxPrice,
      "totalPrice": totalPrice,
    };
  }
}

class OrderItem {
  int id = 0;
  String name = "";
  int quantity = 0;
  double price = 0;
  String imageUrl = "";
  int productId = 0;

  OrderItem({
    this.id = 0,
    this.name = "",
    this.quantity = 0,
    this.price = 0,
    this.imageUrl = "",
    this.productId = 0,
  });

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['_id'].toString()) ?? 0;
    name = json['name'].toString();
    quantity = int.tryParse(json['qty'].toString()) ?? 0;
    price = double.tryParse(json['price'].toString()) ?? 0;
    imageUrl = json['image'].toString();
    productId = int.tryParse(json['product'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "qty": quantity,
      "price": price,
      "image": imageUrl,
      "product": productId,
    };
  }
}

class ShippingAddressItem {
  int id = 0;
  String address = "";
  String city = "";
  int postalCode = 0;
  String country = "";
  double shippingPrice = 0;

  ShippingAddressItem({
    this.id = 0,
    this.address = "",
    this.city = "",
    this.postalCode = 0,
    this.country = "",
    this.shippingPrice = 0,
  });

  ShippingAddressItem.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['_id'].toString()) ?? 0;
    address = json['address'].toString();
    city = json['city'].toString();
    postalCode = int.tryParse(json['postalCode'].toString()) ?? 0;
    country = json['country'].toString();
    shippingPrice = double.tryParse(json['shippingPrice'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "address": address,
      "city": city,
      "postalCode": postalCode,
      "country": country,
      "shippingPrice": shippingPrice,
    };
  }
}
