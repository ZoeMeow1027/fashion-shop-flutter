import 'package:flutter/material.dart';

import '../../config/variables.dart';
import '../../model/cart_history_item.dart';
import 'custom_cache_network_image.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    required this.productItem,
    this.onClickDelete,
  });

  final OrderItem productItem;
  final Function()? onClickDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        shape: BoxShape.rectangle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          CustomCacheNetworkImage(
            imageUrl: "${productItem.imageUrl}",
            height: 90,
            width: 90,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productItem.name,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Variables.mainColor,
                      ),
                    ),
                    Text(
                      "${productItem.price}\$",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Quantity: ${productItem.quantity}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onClickDelete == null
              ? const Center()
              : IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    if (onClickDelete != null) {
                      onClickDelete!();
                    }
                  },
                ),
        ],
      ),
    );
  }
}
