class CartHistoryItem {
  int id = 0;
  List<OrderHistoryItem> cartList = [];
  ShippingAddress? shippingAddress;
  String paymentMethod = "CoD";
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
    shippingAddress = ShippingAddress.fromJson(json['shippingAddress']);
    for (var orderItem in (json['orderItems'] as List<dynamic>)) {
      cartList
          .add(OrderHistoryItem.fromJson(orderItem as Map<String, dynamic>));
    }
  }
}

class OrderHistoryItem {
  int id = 0;
  String name = "";
  int quality = 0;
  double price = 0;
  String imageUrl = "";
  int productId = 0;

  OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['_id'].toString()) ?? 0;
    name = json['name'].toString();
    quality = int.tryParse(json['qty'].toString()) ?? 0;
    price = double.tryParse(json['price'].toString()) ?? 0;
    imageUrl = json['image'].toString();
    productId = int.tryParse(json['product'].toString()) ?? 0;
  }
}

class ShippingAddress {
  int id = 0;
  String address = "";
  String city = "";
  String postalCode = "";
  String country = "";
  double shippingPrice = 0;

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['_id'].toString()) ?? 0;
    address = json['address'].toString();
    city = json['city'].toString();
    postalCode = json['postalCode'].toString();
    country = json['country'].toString();
    shippingPrice = double.tryParse(json['shippingPrice'].toString()) ?? 0;
  }
}
