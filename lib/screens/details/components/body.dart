import 'package:fashionshop/screens/details/components/current_state.dart';
import 'package:fashionshop/screens/details/components/product_basic_interface.dart';
import 'package:fashionshop/screens/details/components/product_color_chooser.dart';
import 'package:flutter/material.dart';

import 'product_counter.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.currentState,
    required this.availableColors,
    required this.previewList,
    required this.onStateChanged,
  });

  final CurrentState currentState;
  final List<int> availableColors;
  final List<String> previewList;
  final Function(CurrentState) onStateChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductBasicInterface(previewList: previewList),
        ProductColorChooser(
          availableColors: availableColors,
          selectedColor: currentState.selectedColor,
          dotSize: 32,
          onClick: (color) {
            var data = currentState;
            data.selectedColor = color;
            onStateChanged(data);
          },
        ),
        ProductCounter(
          count: currentState.selectedCount,
          onChanged: (newCount) {
            var data = currentState;
            data.selectedCount = newCount;
            onStateChanged(data);
          },
        ),
        const Text("Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"
            "Description\n"),
        const Text("Average Rating: 5.0*"),
        const Text("Related products:...."),
      ],
    );
  }
}
