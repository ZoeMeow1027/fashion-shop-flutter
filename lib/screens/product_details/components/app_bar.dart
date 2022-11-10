import 'package:flutter/material.dart';

AppBar appBar({
  required BuildContext context,
  required void Function()? onBackClicked,
  required void Function()? onSearchClicked,
  required void Function()? onCartClicked,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        if (onBackClicked != null) onBackClicked();
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: () {
          if (onSearchClicked != null) onSearchClicked();
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        onPressed: () {
          if (onCartClicked != null) onCartClicked();
        },
      ),
    ],
  );
}
