import 'dart:convert';

import 'package:fashionshop/model/product_item.dart';
import 'package:http/http.dart' as http;

class ProductAPI {
  static const String _baseUrl = "http://127.0.0.1:8000";

  static Future<List<ProductItem>> getProducts() async {
    final List<ProductItem> list = [];

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/products/'),
      );

      // If status code isn't successful, throw exception
      if ((response.statusCode ~/ 100).round() != 2) {
        throw Exception("Server returned with code ${response.statusCode}.");
      }

      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      for (var d in data) {
        list.add(ProductItem.fromJson(d as Map<String, dynamic>));
      }
    } catch (ex) {
      list.clear();
    }

    return list;
  }
}
