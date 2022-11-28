import 'package:flutter/material.dart';

import '../../../model/cart_history_item.dart';
import 'product_item_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    this.productList = const [],
    this.padding = const EdgeInsets.all(0),
    this.onClick,
  });

  final List<OrderHistoryItem> productList;
  final EdgeInsetsGeometry padding;
  final Function(int)? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(productList.length, (index) {
            return ProductItemWidget(
              productItem: productList[index],
              onClick: () {
                if (onClick != null) {
                  onClick!(productList[index].productId);
                }
              },
            );
          }),
        ),
      ),
    );
  }
}
