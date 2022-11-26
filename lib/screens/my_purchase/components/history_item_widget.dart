import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/cart_history_item.dart';
import 'product_list_widget.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({super.key, required this.cartItem});

  final CartHistoryItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      color: Colors.amberAccent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _dateAndStatus(
              date: cartItem.createdAt,
              isPaid: cartItem.paidAt != null,
              isDeliveried: cartItem.deliveredAt != null,
            ),
            ProductListWidget(
              productList: cartItem.cartList,
            ),
            _price(
              totalPrice: cartItem.totalPrice,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Track order"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Delivery status"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateAndStatus({
    DateTime? date,
    required bool isPaid,
    required bool isDeliveried,
  }) {
    return Row(
      children: [
        Text(
          date == null
              ? "Unknown date"
              : "Date: ${DateFormat("dd/MM/yyyy HH:mm").format(date)}",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          !isPaid
              ? "Pending for payment"
              : !isDeliveried
                  ? "Done payment, waiting for delivery"
                  : "Completed",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _price({
    required double totalPrice,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Total price: ',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: '$totalPrice\$',
            style: const TextStyle(color: Colors.red),
          ),
        ],
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
    );
  }
}
