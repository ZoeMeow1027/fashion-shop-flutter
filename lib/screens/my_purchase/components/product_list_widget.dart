import 'package:flutter/material.dart';

import '../../../model/cart_history_item.dart';
import 'product_item_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    this.itemShownCount = 2,
    this.productList = const [],
  });

  final int itemShownCount;
  final List<OrderHistoryItem> productList;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    int count = 0;

    for (var item in productList) {
      // If count is greater than itemShownCount, add remaining items
      // and stop here.
      if (count >= itemShownCount) {
        int remaining = productList.length - count;
        if (remaining > 0) {
          widgetList.add(Container(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
              shape: BoxShape.rectangle,
              color: Colors.white,
              // border: Border.all(
              //   color: Colors.blue,
              //   width: 2,
              // ),
            ),
            child: Center(
              child: Text(
                "${productList.length - count} more item${(productList.length - count) > 1 ? "s" : ""}",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
          ));
        }
        break;
      }
      widgetList.add(ProductItemWidget(productItem: item));

      count += 1;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList,
        ),
      ),
    );
  }
}
