import 'package:fashionshop/screens/home/components/wide_button.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Icon(
            Icons.account_circle_outlined,
            size: 90,
          ),
          const Text("Your Name (Your Username)"),
          wideButton(
            text: "Profile",
            padding: const EdgeInsets.all(3.0),
            onClick: () {},
          ),
          wideButton(
            // TODO: Add more item like In progress, deliveried,...)
            text: "Devilery Status",
            padding: const EdgeInsets.all(3.0),
            onClick: () {},
          ),
          wideButton(
            text: "Vouchers",
            padding: const EdgeInsets.all(3.0),
            onClick: () {},
          ),
          wideButton(
            text: "Account Settings",
            padding: const EdgeInsets.all(3.0),
            onClick: () {},
          ),
          wideButton(
            text: "Points",
            padding: const EdgeInsets.all(3.0),
            onClick: () {},
          ),
          wideButton(
            text: "Help Center",
            padding: const EdgeInsets.all(3.0),
            onClick: () {},
          ),
        ],
      ),
    );
  }
}
