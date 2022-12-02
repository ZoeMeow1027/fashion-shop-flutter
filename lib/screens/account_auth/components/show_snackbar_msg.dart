import 'package:flutter/material.dart';

void showSnackbarMessage({
  required BuildContext context,
  required String msg,
  bool clearOld = true,
}) {
  if (clearOld) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
  ));
}
