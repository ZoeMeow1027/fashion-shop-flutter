import 'package:flutter/material.dart';

import '../../config/variables.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.controller,
    this.isPassword = false,
    this.onSubmitted,
    this.onChanged,
    this.prefixIcon,
    this.borderShow = true,
    this.borderRadius = 5,
    this.borderTextColor = Variables.mainColor,
    this.borderWidth = 1.5,
    this.padding = const EdgeInsets.all(0),
    this.shadowEnabled = false,
  });

  final String? labelText, hintText;
  final Widget? prefixIcon;
  final bool enabled, isPassword, borderShow;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final double borderRadius, borderWidth;
  final Color borderTextColor;
  final EdgeInsetsGeometry padding;
  final bool shadowEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        elevation: shadowEnabled ? 5 : 0,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: TextField(
          controller: controller,
          enabled: enabled,
          obscureText: isPassword,
          enableSuggestions: false,
          autocorrect: false,
          textInputAction: TextInputAction.go,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          onSubmitted: (value) {
            if (onSubmitted != null) {
              onSubmitted!(value);
            }
          },
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: enabled ? TextStyle(color: borderTextColor) : null,
            hintText: hintText,
            prefixIcon: prefixIcon,
            fillColor: Colors.white,
            filled: true,
            enabledBorder: !borderShow
                ? InputBorder.none
                : _outlineInputBorder(
                    borderRadius: borderRadius,
                    borderColor: borderTextColor,
                    borderWidth: borderWidth,
                  ),
            focusedBorder: !borderShow
                ? InputBorder.none
                : _outlineInputBorder(
                    borderRadius: borderRadius,
                    borderColor: borderTextColor,
                    borderWidth: borderWidth,
                  ),
            disabledBorder: !borderShow
                ? InputBorder.none
                : _outlineInputBorder(
                    borderRadius: borderRadius,
                    borderColor: Colors.grey,
                    borderWidth: borderWidth,
                  ),
          ),
        ),
      ),
    );
  }

  // https://www.fluttercampus.com/guide/81/how-to-style-textfield-widget-border-flutter/
  OutlineInputBorder _outlineInputBorder({
    double borderRadius = 5,
    Color borderColor = Colors.blueAccent,
    double borderWidth = 1.5,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      borderSide: BorderSide(width: borderWidth, color: borderColor),
    );
  }
}
