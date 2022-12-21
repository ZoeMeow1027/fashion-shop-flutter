import 'package:flutter/material.dart';

import '../../../model/cart_history_item.dart';
import 'your_cart_item_widget.dart';

class YourCartWidget extends StatelessWidget {
  const YourCartWidget({
    super.key,
    this.productList = const [],
  });

  final List<OrderItem> productList;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList =
        productList.fold(<Widget>[], (previousValue, element) {
      previousValue.add(Container(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: YourCartItemWidget(productItem: element),
      ));
      return previousValue;
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Your Cart",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgetList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
