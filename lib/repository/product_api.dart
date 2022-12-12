import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/configurations.dart';
import '../model/product_item.dart';

class ProductAPI {
  static Future<List<ProductItem>?> getProducts() async {
    try {
      final List<ProductItem> list = [];

      final response = await http.get(
        Uri.parse('${Configurations.baseUrl}/api/products/'),
      );

      // If status code isn't successful, throw exception
      if ((response.statusCode ~/ 100).round() != 2) {
        throw Exception("Server returned with code ${response.statusCode}.");
      }

      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      for (var d in data) {
        list.add(ProductItem.fromJson(d as Map<String, dynamic>));
      }
      return list;
    } catch (ex) {
      return null;
    }
  }
}
