import 'package:fashionshop/model/user_profile.dart';
import 'package:fashionshop/screens/home/components/wide_button.dart';
import 'package:fashionshop/screens/product_search/product_search_view.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({
    super.key,
    this.userProfile,
    this.loginRequested,
  });
  final UserProfile? userProfile;
  final Function()? loginRequested;

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
        child: userProfile == null
            ? _notLoggedIn(
                context: context,
                loginRequested: () {
                  if (loginRequested != null) {
                    loginRequested!();
                  }
                })
            : _loggedIn(context: context, userProfile: userProfile),
      ),
    );
  }

  Widget _notLoggedIn({
    required BuildContext context,
    required Function() loginRequested,
  }) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("You are not logged in"),
          Text("Login to use this application"),
          ElevatedButton(
            onPressed: loginRequested,
            child: const Text("Login", style: TextStyle(fontSize: 14)),
          )
        ],
      ),
    );
  }

  Widget _loggedIn({
    required BuildContext context,
    required UserProfile? userProfile,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Column(
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 70,
              ),
              Text(
                "${userProfile == null ? "" : userProfile.name}",
                style: const TextStyle(fontSize: 20.0),
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
    );
  }
}
