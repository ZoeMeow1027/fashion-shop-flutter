import 'package:flutter/material.dart';

import '../../config/variables.dart';

class CustomNavBarItem extends StatelessWidget {
  const CustomNavBarItem({
    super.key,
    required this.label,
    required this.iconData,
    this.isFilledColor = false,
    this.isActive = false,
  });

  final bool isActive, isFilledColor;
  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
        color: isFilledColor ? Variables.mainColor : Colors.white,
        border: Border.all(
          color: isFilledColor ? Colors.white : Variables.mainColor,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          children: [
            Icon(
              iconData,
              color: isFilledColor ? Colors.white : null,
            ),
            !isActive
                ? const Text("")
                : Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isFilledColor ? Colors.white : null,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
