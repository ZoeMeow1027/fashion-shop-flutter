import 'package:flutter/material.dart';

class AmountSelector extends StatelessWidget {
  const AmountSelector({
    super.key,
    this.count = 0,
    this.countMax = -1,
    required this.onChanged,
  });
  final int count;
  final Function(int) onChanged;
  final int countMax;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text("Count", style: TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 3),
          child: _outlinedButton(
            iconData: Icons.remove,
            onPress: () {
              if (count > 1) onChanged(count - 1);
            },
          ),
        ),
        Text("$count", style: const TextStyle(fontSize: 20)),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 3),
          child: _outlinedButton(
            iconData: Icons.add,
            onPress: () {
              if (count < countMax || countMax == -1) {
                onChanged(count + 1);
              }
            },
          ),
        ),
        _countMax(countMax: countMax),
      ],
    );
  }

  Widget _countMax({int countMax = -1}) {
    return countMax == -1
        ? const Text("")
        : Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Max: $countMax", style: const TextStyle(fontSize: 20)),
          );
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
}
