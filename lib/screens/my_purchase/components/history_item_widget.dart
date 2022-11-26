import 'package:flutter/material.dart';

import '../../../model/cart_history_item.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({super.key, required this.cartItem});

  final CartHistoryItem cartItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("ID"),
          Text("Date & time"),
          Text("Pending"),
          Text("Total price"),
          Text("123"),
        ],
      ),
    );
  }
}
