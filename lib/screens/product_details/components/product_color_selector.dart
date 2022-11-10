import 'package:flutter/material.dart';

class ProductColorSelector extends StatelessWidget {
  const ProductColorSelector({
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
        _ColorDot(
          color: element,
          isSelected: selectedColor == null ? false : selectedColor! == element,
          onClick: (color) {
            onClick(color);
          },
          dotSize: dotSize,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
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
          ),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.color,
    required this.isSelected,
    required this.onClick,
    this.dotSize = 40,
  });

  final bool isSelected;
  final int color;
  final Function(int) onClick;
  final int dotSize;

  @override
  Widget build(BuildContext context) {
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
