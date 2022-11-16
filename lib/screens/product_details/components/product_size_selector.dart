import 'package:flutter/material.dart';

class ProductSizeSelector extends StatelessWidget {
  const ProductSizeSelector({
    super.key,
    required this.sizeList,
    this.selectedIndex = -1,
    required this.onClickedSize,
  });

  final int selectedIndex;
  final List<String> sizeList;
  final Function(int) onClickedSize;

  @override
  Widget build(BuildContext context) {
    List<Widget> allSizeList = [];
    for (int i = 0; i < sizeList.length; i++) {
      allSizeList.add(
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: _sizeSelectorButton(
            text: sizeList[i],
            onClick: () {
              onClickedSize(i);
            },
            isSelected: i == selectedIndex,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Product Sizes",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: allSizeList,
        )
      ],
    );
  }

  OutlinedButton _sizeSelectorButton({
    required String text,
    required Function() onClick,
    bool isSelected = false,
  }) {
    return OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: 2,
        ), //<-- SEE HERE
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
