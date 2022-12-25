class ProductReviewItem {
  late int id;
  late String name;
  double? rating;
  DateTime? createAt;
  String? comment;

  ProductReviewItem.fromJson(Map<String, dynamic> json) {
    id = int.parse(json["_id"].toString());
    name = json["name"].toString();
    rating = double.parse(json["rating"].toString());
    if (json["comment"] == null) {
      comment = null;
    } else {
      comment = json["comment"].toString();
    }
    createAt = DateTime.tryParse(json['createdAt'].toString());
  }
}
