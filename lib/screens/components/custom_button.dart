import 'package:flutter/material.dart';

import '../../config/variables.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onClick,
    required this.label,
    this.labelSize = 17,
    this.icon,
    this.imageIcon,
    this.borderTextColor = Variables.mainColor,
    this.borderWidth = 1.5,
    this.padding = const EdgeInsets.all(0),
    this.verticalPadding = 12,
    this.centerContent = true,
    this.borderEnabled = true,
    this.fillColor = false,
    this.fillMaxWidth = false,
    this.shadowEnabled = false,
  });

  final Function() onClick;
  final String label;
  final double? labelSize;
  final Color borderTextColor;
  final double borderWidth, verticalPadding;
  final EdgeInsetsGeometry padding;
  final bool fillColor,
      centerContent,
      fillMaxWidth,
      shadowEnabled,
      borderEnabled;
  final Icon? icon;
  final ImageIcon? imageIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: fillMaxWidth ? double.infinity : null,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: !shadowEnabled
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
        ),
        child: TextButton(
          onPressed: onClick,
          style: TextButton.styleFrom(
            backgroundColor: fillColor ? borderTextColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: !borderEnabled
                  ? BorderSide.none
                  : BorderSide(
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
                        icon!.icon,
                        color: fillColor ? Colors.white : Variables.mainColor,
                        size: 25,
                      ),
                (imageIcon == null || icon != null)
                    ? const Center()
                    : ImageIcon(
                        imageIcon!.image,
                        color: Variables.mainColor,
                        size: 25,
                      ),
                Padding(
                  padding: (icon != null || imageIcon != null)
                      ? const EdgeInsets.only(left: 15)
                      : const EdgeInsets.all(0),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: fillColor ? Colors.white : borderTextColor,
                      fontSize: labelSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
