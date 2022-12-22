import 'package:flutter/material.dart';

import '../../config/variables.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onClick,
    required this.label,
    this.labelSize = 17,
    this.icon,
    this.centerContent = true,
    this.borderTextColor = Variables.mainColor,
    this.borderWidth = 1.5,
    this.verticalPadding = 5,
    this.isFilledColor = false,
    this.padding = const EdgeInsets.all(0),
    this.fillMaxWidth = false,
  });

  final Function() onClick;
  final String label;
  final double? labelSize;
  final Color borderTextColor;
  final bool isFilledColor, centerContent;
  final double borderWidth, verticalPadding;
  final EdgeInsetsGeometry padding;
  final bool fillMaxWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: fillMaxWidth ? double.infinity : null,
      child: TextButton(
        onPressed: onClick,
        style: TextButton.styleFrom(
          backgroundColor: isFilledColor ? borderTextColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderTextColor,
              width: borderWidth,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 8),
          child: Row(
            mainAxisAlignment: centerContent
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon == null
                  ? const Center()
                  : Icon(
                      icon,
                      color: isFilledColor ? Colors.white : Variables.mainColor,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isFilledColor ? Colors.white : borderTextColor,
                    fontSize: labelSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
