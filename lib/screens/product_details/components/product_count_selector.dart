import 'package:flutter/material.dart';

class ProductCountSelector extends StatelessWidget {
  const ProductCountSelector({
    super.key,
    this.count = 0,
    required this.onChanged,
  });
  final int count;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Text("Count", style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 3.0),
                child: _outlinedButton(
                  iconData: Icons.remove,
                  onPress: () {
                    if (count > 1) onChanged(count - 1);
                  },
                ),
              ),
              Text("$count", style: const TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 3.0),
                child: _outlinedButton(
                  iconData: Icons.add,
                  onPress: () {
                    onChanged(count + 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _outlinedButton({
  required IconData iconData,
  required Function onPress,
  int width = 40,
  int height = 40,
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
