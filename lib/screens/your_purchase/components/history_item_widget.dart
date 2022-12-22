import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/cart_history_item.dart';
import 'product_list_widget.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({
    super.key,
    required this.cartItem,
    this.onClickTrackOrder,
    this.onClickDeliveryStatus,
  });

  final CartHistoryItem cartItem;
  final Function()? onClickTrackOrder;
  final Function()? onClickDeliveryStatus;

  // Get color from delivery status.
  Color _colorStatus() {
    // If not paid
    if (cartItem.paidAt == null) {
      return Colors.redAccent;
    }
    // If paid but not deliveried
    if (cartItem.paidAt != null && cartItem.deliveredAt == null) {
      return Colors.orangeAccent;
    }
    // If deliveried
    if (cartItem.paidAt != null && cartItem.deliveredAt != null) {
      return Colors.greenAccent;
    }
    // Other status will no color.
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      foregroundDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: _colorStatus(),
            width: 6,
          ),
        ),
      ),
      color: const Color.fromARGB(255, 235, 235, 235),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.only(bottom: 10),
            ),
            onClickTrackOrder != null
                ? SizedBox(
                    width: double.infinity,
                    child: _customButton(
                      onClick: onClickTrackOrder,
                      backgroundColor: const Color.fromARGB(255, 127, 186, 34),
                      textColor: Colors.white,
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      text: "Track order",
                    ),
                  )
                : const Center(),
            SizedBox(
              width: double.infinity,
              child: _customButton(
                onClick: onClickDeliveryStatus,
                padding: const EdgeInsets.only(top: 3, bottom: 3),
                text: "Delivery status",
              ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date == null
              ? "Unknown date"
              : "Date: ${DateFormat("dd/MM/yyyy HH:mm").format(date)}",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        Text(
          !isPaid
              ? "Not paid yet"
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
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) {
    return Container(
      alignment: Alignment.centerRight,
      padding: padding,
      child: RichText(
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
      ),
    );
  }

  Widget _customButton({
    Function()? onClick,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) {
    return Padding(
      padding: padding,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: backgroundColor ?? Colors.blue,
              width: 1.5,
            ),
          ),
        ),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
