import 'package:flutter/material.dart';

import '../../../model/cart_history_item.dart';

class ShippingAddressInfoWidget extends StatelessWidget {
  const ShippingAddressInfoWidget({
    super.key,
    required this.name,
    required this.address,
    this.padding = const EdgeInsets.all(0),
    this.onClickChange,
  });

  final String name;
  final ShippingAddressItem address;
  final EdgeInsetsGeometry padding;
  final Function()? onClickChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    "Shipping Address",
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    // https://stackoverflow.com/a/52228086
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontFamily: "Metropolis",
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Text(
                        address.address,
                        style: const TextStyle(
                            fontFamily: "Metropolis", fontSize: 18),
                      ),
                      Text(
                        "${address.city}, ${address.postalCode}, ${address.country}",
                        style: const TextStyle(
                            fontFamily: "Metropolis", fontSize: 18),
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
