import 'package:flutter/material.dart';

import '../../model/cart_history_item.dart';
import 'order_item_widget.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({
    super.key,
    required this.productList,
    this.label,
    this.maxItemsShow = 0,
    this.onClickItem,
  });

  final List<OrderItem> productList;
  final String? label;
  final int maxItemsShow;
  final Function(int)? onClickItem;
  // TODO: Max Item show

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = productList.fold(
      <Widget>[],
      (previousValue, element) {
        previousValue.add(
          Container(
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: InkWell(
              onTap: () {
                if (onClickItem != null) {
                  onClickItem!(element.id);
                }
              },
              child: OrderItemWidget(productItem: element),
            ),
          ),
        );
        return previousValue;
      },
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label == null
                  ? const Center()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "$label",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
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
