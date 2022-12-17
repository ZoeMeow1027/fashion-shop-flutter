// TODO: API instead of local storage

import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart_history_item.dart';
import '../model/product_item.dart';
import 'product_api.dart';

class CartAPI {
  static Future<void> addToCart({
    required String token,
    required int productId,
    int count = 1,
  }) async {
    // TODO: Check if token is valid.

    if (count < 1) {
      throw Exception("Invalid count argument (count must be greater than 0)");
    }

    ProductItem? item;
    try {
      item = (await ProductAPI.getProducts())?.firstWhere((element) {
        return element.id == productId;
      });
    } catch (ex) {
      log("[E] addToCart: ${ex.toString()}");
    }
    if (item == null) {
      throw Exception("addToCart: \"item\" was empty!");
    }

    if (count > item.countInStock) {
      throw Exception(
          "addToCart: Count in stock with product id \"$productId\" was less than \"count\" argument!");
    }

    OrderItem orderItem = OrderItem(
      productId: item.id!,
      name: item.name!,
      quantity: count,
      price: item.price!,
      imageUrl: item.imageUrl!,
    );

    log("addToCart: OK");

    // Add or modify to local storage
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("cart");
    try {
      // Check if no cart in local storage. If so, throw exception here.
      if (data == null) {
        throw Exception("[W] addToCart: No data in local storage");
      }
      // Get all product in cart.
      List<OrderItem> list = await getCart(token: token);

      try {
        // Get product from id
        OrderItem iTemp = list
            .where((element) => element.productId == orderItem.productId)
            .first;

        // Remove old item
        list.remove(iTemp);

        // Modify in itemp
        iTemp.price = orderItem.price;
        iTemp.quantity += orderItem.quantity;
        item.imageUrl = orderItem.imageUrl;

        // Add to cart
        list.add(iTemp);
      } catch (ex) {
        // If not exist item but exist list, just add.
        list.add(orderItem);
      }
      prefs.setString("cart", jsonEncode(list));
    } catch (ex) {
      // Add new cart if data is null before.
      List<OrderItem> list = [];
      list.add(orderItem);
      prefs.setString("cart", jsonEncode(list));
    }
  }

  static Future<List<OrderItem>> getCart({
    required String token,
  }) async {
    // Get cart from local storage
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("cart");

    // If null data, return empty array.
    if (data == null) {
      return [];
    }

    // Otherwise, try to get from local storage
    List<OrderItem> list = List.castFrom(json.decode(data))
        .toList()
        .map((val) => OrderItem.fromJson(val))
        .toList();

    // Return list
    return list;
  }

  static Future<void> removeFromCart({
    required String token,
    required int productId,
  }) async {
    // TODO: Remove a item from local storage
  }
}
