import 'package:flutter/material.dart';

Widget wideButton({
  required String text,
  required Function() onClick,
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
}) {
  return Padding(
    padding: padding,
    child: TextButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(text),
        ),
      ),
    ),
  );
}
