import 'package:flutter/material.dart';

import 'two_lines_widget.dart';

class PriceDetailsWidget extends StatelessWidget {
  const PriceDetailsWidget({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.basePrice,
    this.taxPrice,
    this.shipPrice,
    this.totalPrice,
  });

  final EdgeInsetsGeometry padding;
  final double? basePrice;
  final double? taxPrice;
  final double? shipPrice;
  final double? totalPrice;

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
              text: "Base price",
              value: "${basePrice != null ? "\$" : ""}$basePrice",
              textIfValueNull: "Unknown",
              padding: const EdgeInsets.only(top: 2, bottom: 2),
            ),
            TwoLinesWidget(
              text: "Tax price",
              value: "${taxPrice != null ? "\$" : ""}$taxPrice",
              textIfValueNull: "Unknown",
              padding: const EdgeInsets.only(top: 2, bottom: 2),
            ),
            TwoLinesWidget(
              text: "Shipping price",
              value: "${shipPrice != null ? "\$" : ""}$shipPrice",
              textIfValueNull: "Unknown",
              padding: const EdgeInsets.only(top: 2, bottom: 2),
            ),
            TwoLinesWidget(
              text: "Total amount",
              value: "${totalPrice != null ? "\$" : ""}$totalPrice",
              textIfValueNull: "Unknown",
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              fontColor: Colors.redAccent,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
