import 'package:flutter/material.dart';

//https://www.fluttercampus.com/guide/81/how-to-style-textfield-widget-border-flutter/
OutlineInputBorder _outlineInputBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(width: 2),
  );
}

TextField customOutlinedTextField({
  required String text,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      enabledBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
    ),
  );
}
