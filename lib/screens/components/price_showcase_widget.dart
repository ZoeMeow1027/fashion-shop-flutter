import 'package:flutter/material.dart';

class PriceShowcaseWidget extends StatelessWidget {
  const PriceShowcaseWidget({
    super.key,
    required this.priceTotalCart,
    required this.priceShip,
    this.taxPercent = 8,
    this.padding = const EdgeInsets.all(0),
    this.priceTax,
    this.priceTotalAmount,
  });

  final double priceTotalCart;
  final double priceShip;
  final double taxPercent;
  final EdgeInsetsGeometry padding;
  final double? priceTax, priceTotalAmount;

  @override
  Widget build(BuildContext context) {
    final priceTax = priceTotalCart * taxPercent / 100;
    final priceTotalAmount = priceTotalCart + priceTax + priceShip;
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _priceLine(label: "Total cart", price: priceTotalCart),
              _priceLine(label: "Tax", price: this.priceTax ?? priceTax),
              _priceLine(label: "Shipping", price: priceShip),
              _priceLine(
                label: "Total amount",
                price: this.priceTotalAmount ?? priceTotalAmount,
                fontSize: 22,
                padding: const EdgeInsets.only(top: 5, bottom: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceLine({
    required String label,
    double price = 0,
    double? fontSize = 18,
    EdgeInsetsGeometry padding = const EdgeInsets.only(top: 2, bottom: 2),
  }) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: "Metropolis",
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 155, 155, 155),
            ),
          ),
          const Spacer(),
          Text(
            "$price\$",
            style: TextStyle(
              fontFamily: "Metropolis",
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
