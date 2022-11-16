import 'package:fashionshop/screens/product_details/components/current_state.dart';
import 'package:fashionshop/screens/product_details/components/color_selector.dart';
import 'package:fashionshop/screens/product_details/components/amount_selector.dart';
import 'package:fashionshop/screens/product_details/components/product_size_selector.dart';
import 'package:flutter/material.dart';

class OrderOptions extends StatelessWidget {
  const OrderOptions({
    super.key,
    required this.availableColors,
    required this.availableSize,
    this.inventoryMax = -1,
    required this.currentState,
    required this.onStateChanged,
  });

  final List<int> availableColors;
  final List<String> availableSize;
  final CurrentState currentState;
  final Function(CurrentState) onStateChanged;
  final int inventoryMax;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ProductSizeSelector(
                sizeList: availableSize,
                selectedIndex: currentState.selectedSizeIndex,
                onClickedSize: (sizeSelected) {
                  var data = currentState;
                  data.selectedSizeIndex = sizeSelected;
                  onStateChanged(data);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ColorSelector(
                availableColors: availableColors,
                selectedColor: currentState.selectedColor,
                dotSize: 40,
                onClick: (color) {
                  var data = currentState;
                  data.selectedColor = color;
                  onStateChanged(data);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: AmountSelector(
                count: currentState.selectedCount,
                countMax: inventoryMax,
                onChanged: (newCount) {
                  var data = currentState;
                  data.selectedCount = newCount;
                  onStateChanged(data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
