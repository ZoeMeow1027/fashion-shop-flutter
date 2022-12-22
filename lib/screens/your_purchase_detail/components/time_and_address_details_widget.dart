import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/cart_history_item.dart';
import 'two_lines_widget.dart';

class TimeAndAddressDetailsWidget extends StatelessWidget {
  const TimeAndAddressDetailsWidget({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.paidAt,
    this.deliveriedAt,
    this.shippingAddress,
  });

  final EdgeInsetsGeometry padding;
  final DateTime? paidAt;
  final DateTime? deliveriedAt;
  final ShippingAddressItem? shippingAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TwoLinesWidget(
              text: "Paid at",
              value: paidAt == null
                  ? "Not paid yet"
                  : DateFormat("dd/MM/yyyy HH:mm").format(paidAt!),
              textIfValueNull: "Unknown",
              padding: const EdgeInsets.only(top: 2, bottom: 2),
            ),
            TwoLinesWidget(
              text: "Deliveried at",
              value: deliveriedAt == null
                  ? "Not deliveried yet"
                  : DateFormat("dd/MM/yyyy HH:mm").format(deliveriedAt!),
              textIfValueNull: "Unknown",
              padding: const EdgeInsets.only(top: 2, bottom: 2),
            ),
            shippingAddress == null
                ? const Center()
                : TwoLinesWidget(
                    text: "Delivery address   ",
                    value:
                        "${shippingAddress!.address}, ${shippingAddress!.city}, ${shippingAddress!.country}",
                    textIfValueNull: "Unknown",
                  ),
          ],
        ),
      ),
    );
  }
}
