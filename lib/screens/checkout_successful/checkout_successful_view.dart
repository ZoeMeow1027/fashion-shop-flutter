import 'package:flutter/material.dart';

import '../home/home_view.dart';

class CheckoutSuccessfulView extends StatelessWidget {
  const CheckoutSuccessfulView({super.key, required this.orderId});

  final String orderId;
  // final Function() returnHomeClicked;
  // final Function() deliveryStatusClicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 90.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Column(children: [
                const Text(
                  "Order Completed",
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  "Your order $orderId was placed successfully.",
                  style: const TextStyle(fontSize: 15.0),
                ),
                const Text(
                  "For more details, check Delivery Status under Profile tab.",
                  style: TextStyle(fontSize: 15.0),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Delivery Status"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Return to home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
