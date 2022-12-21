import 'package:flutter/material.dart';

import '../../../model/payment_method.dart';

class PaymentInfoWidget extends StatelessWidget {
  const PaymentInfoWidget({
    super.key,
    this.method = PaymentMethod.CoD,
    this.numberInfo,
    this.padding = const EdgeInsets.all(0),
    this.onClickChange,
  });

  final String method;
  final String? numberInfo;
  final EdgeInsetsGeometry padding;
  final Function()? onClickChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Payment Method",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      if (onClickChange != null) {
                        onClickChange!();
                      }
                    },
                    child: const Text(
                      "Change",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        method,
                        style: const TextStyle(
                            fontFamily: "Metropolis", fontSize: 21),
                      ),
                      numberInfo == null
                          ? const Center()
                          : Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                numberInfo!,
                                style: const TextStyle(
                                    fontFamily: "Metropolis", fontSize: 21),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
