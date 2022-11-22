class ProductItem {
  int? id;
  dynamic review;
  int reviewNum = 0;
  String? name;
  String? imageUrl;
  String? brand;
  String? category;
  String? description;
  double? rating;
  double? price;
  int countInStock = 0;
  DateTime? createdAt;

  ProductItem.fromJson(Map<String, dynamic> json) {
    id = int.parse(json["_id"].toString());
    name = json["name"].toString();
    imageUrl = json["image"].toString();
    brand = json["brand"].toString();
    category = json["category"].toString();
    description = json["description"].toString();
    rating = double.tryParse(json["rating"].toString());
    reviewNum = int.tryParse(json["numReviews"].toString()) ?? 0;
    price = double.tryParse(json["price"].toString());
    countInStock = int.tryParse(json['countInStock'].toString()) ?? 0;
    createdAt = DateTime.tryParse(json['createAt'].toString());
  }
}
