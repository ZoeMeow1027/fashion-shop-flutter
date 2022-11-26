import 'package:flutter/material.dart';

import '../../../model/cart_history_item.dart';
import '../../../repository/order_api.dart';

class ViewModel extends ChangeNotifier {
  ViewModel({required this.tokenKey});

  final String tokenKey;

  List<CartHistoryItem> cartHistoryList = [];

  void updateUI() {
    notifyListeners();
  }

  Future<void> getCartHistory({Function()? onDone}) async {
    cartHistoryList.clear();
    cartHistoryList.addAll(await OrderAPI.getCartHistory(tokenKey));

    if (onDone != null) {
      onDone();
    }
    updateUI();
  }
}
