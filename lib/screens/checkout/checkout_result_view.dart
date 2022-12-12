import 'package:flutter/material.dart';

class CheckoutResultView extends StatelessWidget {
  const CheckoutResultView({
    super.key,
    required this.orderId,
    this.orderStatus = -1,
    this.returnHomeClicked,
    this.deliveryStatusClicked,
  });

  final String orderId;
  // -1: Cancelled, 0: Failed, 1: Successful
  final int orderStatus;
  final Function()? returnHomeClicked;
  final Function()? deliveryStatusClicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orderStatus == -1
          ? Colors.white
          : orderStatus == 0
              ? Colors.redAccent
              : Colors.greenAccent,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                orderStatus == -1 || orderStatus == 0
                    ? Icons.do_disturb_alt_rounded
                    : Icons.check_circle_outline_rounded,
                size: 90,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        orderStatus == -1
                            ? "Order Cancelled"
                            : orderStatus == 0
                                ? "Order Failed"
                                : "Order Completed",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Your order $orderId was ${orderStatus == -1 ? "cancelled" : orderStatus == 0 ? "failed" : "placed successfully"}.",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${orderStatus == -1 || orderStatus == 0 ? "To buy your previous cart again or for more details" : "For more details"}, check Delivery Status under Profile tab or click button below.",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 100, right: 100),
                child: ElevatedButton(
                  onPressed: () {
                    if (deliveryStatusClicked != null) {
                      deliveryStatusClicked!();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child: const Text("Delivery Status"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 100, right: 100),
                child: ElevatedButton(
                  onPressed: () {
                    if (returnHomeClicked != null) {
                      returnHomeClicked!();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child: const Text("Return to home"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
