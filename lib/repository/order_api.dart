import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/urls.dart';
import '../model/cart_history_item.dart';

class OrderAPI {
  static Future<List<CartHistoryItem>> getCartHistory(String token) async {
    List<CartHistoryItem> list = [];

    try {
      final response = await http.get(
        Uri.parse('${Urls.urlBase}${Urls.urlMyOrders}'),
        headers: {HttpHeaders.authorizationHeader: token},
      );

      // If status code isn't successful, throw exception
      if ((response.statusCode ~/ 100).round() != 2) {
        throw Exception("Server returned with code ${response.statusCode}.");
      }

      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      for (var d in data) {
        list.add(CartHistoryItem.fromJson(d as Map<String, dynamic>));
      }
    } catch (ex) {
      list.clear();
    }

    return list;
  }

  static Future<int> addCart(String token, CartHistoryItem cartItem) async {
    try {
      final response = await http.post(
        Uri.parse('${Urls.urlBase}${Urls.urlAddOrder}'),
        headers: {
          HttpHeaders.authorizationHeader: token,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(cartItem),
      );

      // If status code isn't successful, throw exception
      if ((response.statusCode ~/ 100).round() != 2) {
        throw Exception("Server returned with code ${response.statusCode}.");
      }

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return int.parse(data['_id'].toString());
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<void> markAsPaid(String token, int orderId) async {
    try {
      final response = await http.put(
        Uri.parse('${Urls.urlBase}/api/orders/$orderId/pay/'),
        headers: {HttpHeaders.authorizationHeader: token},
      );

      // If status code isn't successful, throw exception
      if ((response.statusCode ~/ 100).round() != 2) {
        throw Exception("Server returned with code ${response.statusCode}.");
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }
}
