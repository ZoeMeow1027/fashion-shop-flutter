import 'package:fashionshop/screens/components/custom_navbar_item.dart';
import 'package:flutter/material.dart';

import '../../config/variables.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.navBarList,
    this.currentIndex = 0,
    this.onChangedIndex,
    this.isFilledColor = false,
  });

  final List<CustomNavBarItem> navBarList;
  final int currentIndex;
  final Function(int)? onChangedIndex;
  final bool isFilledColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        foregroundDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          border: Border.all(
            color: Variables.mainColor,
            width: 2,
          ),
        ),
        color: isFilledColor ? Variables.mainColor : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            navBarList.length,
            (index) {
              CustomNavBarItem item = navBarList[index];
              if (index == currentIndex) {
                item = CustomNavBarItem(
                  label: item.label,
                  iconData: item.iconData,
                  isFilledColor: item.isFilledColor,
                  isActive: true,
                );
              }
              return InkWell(
                onTap: () {
                  if (onChangedIndex != null) {
                    onChangedIndex!(index);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: item,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
