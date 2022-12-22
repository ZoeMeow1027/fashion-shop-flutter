import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    this.deliveryId = 0,
    this.date,
    this.status = "Waiting for payment...",
    this.bgColor = const Color.fromARGB(255, 255, 219, 61),
  });

  final int deliveryId;
  final DateTime? date;
  final String status;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.asset(
              'assets/img/package.jpg',
              height: 84,
              width: 84,
              filterQuality: FilterQuality.high,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Delivery ID: $deliveryId",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  date == null
                      ? "Unknown date created for this delivery"
                      : "Created at ${DateFormat("dd/MM/yyyy HH:mm").format(date!)}",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Text(
                  status,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
