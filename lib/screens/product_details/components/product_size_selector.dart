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
          child: _SizeSelectorButton(
            text: sizeList[i],
            isSelected: i == selectedIndex,
            onClick: () {
              onClickedSize(i);
            },
          ),
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
          ),
        ),
      ),
    );
  }
}

class _SizeSelectorButton extends StatelessWidget {
  const _SizeSelectorButton({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onClick,
  });

  final String text;
  final bool isSelected;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
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
