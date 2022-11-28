import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    this.isPaid = false,
    this.onClickContact,
    this.onClickPayment,
  });

  final bool isPaid;
  final Function()? onClickPayment;
  final Function()? onClickContact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !isPaid
              ? _customButton(
                  text: "Complete Payment",
                  textColor: Colors.black,
                  onClick: onClickPayment,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                )
              : const Center(),
          _customButton(
            text: "Need help?",
            textColor: Colors.black,
            onClick: onClickContact,
            padding: const EdgeInsets.only(left: 5, right: 5),
          ),
        ],
      ),
    );
  }

  Widget _customButton({
    Function()? onClick,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) {
    return Padding(
      padding: padding,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: backgroundColor ?? Colors.blue,
              width: 1.5,
            ),
          ),
        ),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
