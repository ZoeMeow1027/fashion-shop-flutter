import 'package:flutter/material.dart';

//https://www.fluttercampus.com/guide/81/how-to-style-textfield-widget-border-flutter/
OutlineInputBorder _outlineInputBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(width: 1.5, color: Colors.blueAccent),
  );
}

TextField customOutlinedTextField({
  required String text,
  bool enabled = true,
  bool isPassword = false,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    enabled: enabled,
    obscureText: isPassword,
    enableSuggestions: false,
    autocorrect: false,
    decoration: InputDecoration(
      labelText: text,
      enabledBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
    ),
  );
}
