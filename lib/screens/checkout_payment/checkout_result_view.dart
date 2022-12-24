import 'package:flutter/material.dart';

import '../../config/variables.dart';
import '../components/custom_button.dart';

class CheckoutResultView extends StatelessWidget {
  const CheckoutResultView({
    super.key,
    required this.orderId,
    this.returnHomeClicked,
    this.deliveryStatusClicked,
  });

  final String orderId;
  final Function()? returnHomeClicked;
  final Function()? deliveryStatusClicked;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Variables.mainColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 90,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 15),
                        child: Text(
                          "Order Completed",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Your order with ID $orderId was placed successfully.",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        "For more details, check Delivery Status under Profile tab or click button below.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  padding: const EdgeInsets.only(
                      top: 35, bottom: 5, left: 100, right: 100),
                  fillMaxWidth: true,
                  fillColor: false,
                  label: "Delivery Status",
                  onClick: () {
                    if (deliveryStatusClicked != null) {
                      deliveryStatusClicked!();
                    }
                  },
                ),
                CustomButton(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 5, left: 100, right: 100),
                  fillMaxWidth: true,
                  fillColor: false,
                  label: "Return to Home",
                  onClick: () {
                    if (returnHomeClicked != null) {
                      returnHomeClicked!();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
