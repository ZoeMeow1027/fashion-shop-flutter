import 'package:flutter/material.dart';

class TwoLinesWidget extends StatelessWidget {
  const TwoLinesWidget({
    super.key,
    required this.text,
    this.value,
    this.textIfValueNull = "",
    this.padding = const EdgeInsets.all(0),
    this.fontColor,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
  });

  final String text;
  final String? value;
  final String textIfValueNull;
  final EdgeInsetsGeometry padding;
  final Color? fontColor;
  final double fontSize;
  final FontWeight fontWeight;

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
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
          Expanded(
            child: Text(
              value == null ? textIfValueNull : "$value",
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
