import 'package:flutter/material.dart';

class ProductCounter extends StatelessWidget {
  const ProductCounter({
    super.key,
    this.count = 0,
    required this.onChanged,
  });
  final int count;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Text("Count"),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: _outlinedButton(
            iconData: Icons.remove,
            onPress: () {
              if (count > 1) onChanged(count - 1);
            },
          ),
        ),
        Text("$count"),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: _outlinedButton(
            iconData: Icons.add,
            onPress: () {
              onChanged(count + 1);
            },
          ),
        ),
      ],
    );
  }
}

Widget _outlinedButton({
  required IconData iconData,
  required Function onPress,
  int width = 32,
  int height = 32,
}) {
  return SizedBox(
    width: width.toDouble(),
    height: height.toDouble(),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
      onPressed: () {
        onPress();
      },
      child: Icon(iconData),
    ),
  );
}
