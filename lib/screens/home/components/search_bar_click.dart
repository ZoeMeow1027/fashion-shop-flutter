import 'package:flutter/material.dart';

class SearchBarClick extends StatelessWidget {
  const SearchBarClick({
    super.key,
    required this.placeholderText,
    required this.onClick,
  });

  final String placeholderText;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return customOutlinedTextField(
      text: placeholderText,
      controller: TextEditingController(),
      onClick: () {
        onClick();
      },
    );
  }

  //https://www.fluttercampus.com/guide/81/how-to-style-textfield-widget-border-flutter/
  OutlineInputBorder _outlineInputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(width: 1),
    );
  }

  Widget customOutlinedTextField({
    required String text,
    required TextEditingController controller,
    required Function onClick,
  }) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: TextField(
        controller: controller,
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          labelText: text,
          enabledBorder: _outlineInputBorder(),
          focusedBorder: _outlineInputBorder(),
          disabledBorder: _outlineInputBorder(),
        ),
      ),
    );
  }
}
