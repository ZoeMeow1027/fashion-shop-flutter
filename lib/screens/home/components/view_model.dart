import 'package:fashionshop/model/product_item.dart';
import 'package:fashionshop/model/user_profile.dart';
import 'package:fashionshop/repository/product_api.dart';
import 'package:fashionshop/repository/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  int currentPage = 0;
  List<ProductItem> productItemList = [];
  String? tokenKey;
  UserProfile? userProfile;

  void updateUI() {
    notifyListeners();
  }

  Future<void> checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    tokenKey = prefs.getString("tokenKey");

    if (tokenKey == null) {
      prefs.remove("tokenKey");
    } else if (!(await UserAPI.isLoggedIn(tokenKey!))) {
      prefs.remove("tokenKey");
    } else {
      userProfile = await UserAPI.getProfile(tokenKey!);
    }
    notifyListeners();
  }

  Future<void> getProductList() async {
    productItemList = await ProductAPI.getProducts();
    notifyListeners();
  }
}