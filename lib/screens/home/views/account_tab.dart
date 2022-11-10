import 'package:fashionshop/screens/home/components/wide_button.dart';
import 'package:fashionshop/screens/product_search/product_search_view.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Account"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductSearchView()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 90,
                  ),
                  const Text(
                    "Your Name (Your Username)",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
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
            wideButton(
              text: "App Settings",
              padding: const EdgeInsets.all(3.0),
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
