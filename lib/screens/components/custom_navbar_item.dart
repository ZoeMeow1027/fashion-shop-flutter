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
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: isFilledColor
              ? (isActive ? Colors.white : Variables.mainColor)
              : (isActive ? Variables.mainColor : Colors.white),
          border: Border.all(
            color: isFilledColor
                ? (isActive ? Variables.mainColor : Colors.white)
                : (isActive ? Colors.white : Variables.mainColor),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            children: [
              Icon(
                iconData,
                color: isFilledColor
                    ? (isActive ? Variables.mainColor : Colors.white)
                    : (isActive ? Colors.white : Variables.mainColor),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                child: !isActive
                    ? const Text("")
                    : Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          label,
                          style: TextStyle(
                            color: isFilledColor
                                ? (isActive
                                    ? Variables.mainColor
                                    : Colors.white)
                                : (isActive
                                    ? Colors.white
                                    : Variables.mainColor),
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
