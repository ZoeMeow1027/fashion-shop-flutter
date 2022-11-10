import 'package:flutter/material.dart';

Widget wideButton({
  required String text,
  required Function() onClick,
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
}) {
  return Padding(
    padding: padding,
    child: OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(55.0),
        backgroundColor: Colors.blue,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(text,
              style: const TextStyle(fontSize: 16.0, color: Colors.white)),
        ),
      ),
    ),
  );
}
