import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
    required this.availableColors,
    required this.selectedColor,
    required this.onClick,
    this.dotSize = 40,
  });
  final List<int> availableColors;
  final int? selectedColor;
  final Function(int) onClick;
  final int dotSize;

  @override
  Widget build(BuildContext context) {
    List<Widget> listColor = [];
    for (var element in availableColors) {
      listColor.add(
        _colorDot(
          color: element,
          isSelected: selectedColor == null ? false : selectedColor! == element,
          onClick: (color) {
            onClick(color);
          },
          dotSize: dotSize,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Product Colors",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listColor,
        ),
      ],
    );
  }

  Widget _colorDot({
    required int color,
    required bool isSelected,
    required Function(int) onClick,
    int dotSize = 40,
  }) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(2.5),
        height: dotSize.toDouble(),
        width: dotSize.toDouble(),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Color(color) : Colors.transparent,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(color),
            shape: BoxShape.circle,
          ),
        ),
      ),
      onTap: () {
        onClick(color);
      },
    );
  }
}
