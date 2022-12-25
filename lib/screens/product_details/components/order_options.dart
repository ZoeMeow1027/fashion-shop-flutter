import 'package:flutter/material.dart';

import '../../../config/variables.dart';
import 'amount_selector.dart';
import 'color_selector.dart';
import 'product_size_selector.dart';

class OrderOptions extends StatelessWidget {
  const OrderOptions({
    super.key,
    this.availableColors,
    this.availableSize,
    required this.selectedColorIndex,
    required this.selectedSizeIndex,
    required this.currentCount,
    this.inventoryMax = -1,
    required this.onStateChanged,
  });

  final List<int>? availableColors;
  final List<String>? availableSize;
  // Size, Color, Count
  final Function(int, int, int) onStateChanged;
  final int selectedSizeIndex, selectedColorIndex, currentCount, inventoryMax;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Card(
        color: Variables.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            availableSize == null
                ? const Center()
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ProductSizeSelector(
                      sizeList: availableSize!,
                      selectedIndex: selectedColorIndex,
                      onClickedSize: (sizeSelected) {
                        onStateChanged(
                            sizeSelected, selectedColorIndex, currentCount);
                      },
                    ),
                  ),
            availableColors == null
                ? const Center()
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ColorSelector(
                      availableColors: availableColors!,
                      selectedColor: selectedColorIndex,
                      dotSize: 40,
                      onClick: (color) {
                        onStateChanged(selectedSizeIndex,
                            availableColors!.elementAt(color), currentCount);
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: AmountSelector(
                count: currentCount,
                countMax: inventoryMax,
                onChanged: (newCount) {
                  onStateChanged(
                      selectedSizeIndex, selectedColorIndex, newCount);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
