import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar appBar({
  required BuildContext context,
  required void Function()? onBackClicked,
  required void Function()? onSearchClicked,
  required void Function()? onCartClicked,
}) {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset(
        'assets/icons/back.svg',
        color: Colors.white,
      ),
      onPressed: () {
        if (onBackClicked != null) onBackClicked();
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          if (onSearchClicked != null) onSearchClicked();
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          if (onCartClicked != null) onCartClicked();
        },
      ),
    ],
  );
}
