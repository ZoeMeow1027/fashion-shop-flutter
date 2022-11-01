import 'package:flutter/material.dart';

import '../home/home_view.dart';

class OrderSuccessfulView extends StatelessWidget {
  const OrderSuccessfulView({super.key});

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
            const Text("Order Completed"),
            const Text("Your order F348GF843FD2J was placed successfully."),
            const Text(
                "For more details, check Delivery Status under Profile tab."),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Delivery Status"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
