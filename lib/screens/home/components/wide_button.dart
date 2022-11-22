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
      style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(80.0),
          backgroundColor: const Color.fromARGB(255, 242, 243, 247),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side:
                  const BorderSide(color: Color.fromARGB(255, 182, 183, 189)))),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 5),
          child: Text(text,
              style: const TextStyle(fontSize: 16.0, color: Colors.black)),
        ),
      ),
    ),
  );
}
