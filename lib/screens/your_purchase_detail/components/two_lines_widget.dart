import 'package:flutter/material.dart';

class TwoLinesWidget extends StatelessWidget {
  const TwoLinesWidget({
    super.key,
    required this.text,
    this.value,
    this.textIfValueNull = "",
    this.padding = const EdgeInsets.all(0),
  });

  final String text;
  final String? value;
  final String textIfValueNull;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color.fromARGB(255, 155, 155, 155),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Text(
              value == null ? textIfValueNull : "$value",
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
