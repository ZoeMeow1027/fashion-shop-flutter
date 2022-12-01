import 'package:fashionshop/model/user_profile.dart';
import 'package:fashionshop/screens/account_profile/account_profile_view.dart';
import 'package:fashionshop/screens/home/components/account_banner_widget.dart';
import 'package:fashionshop/screens/home/components/view_model.dart';
import 'package:fashionshop/screens/home/components/wide_button.dart';
import 'package:fashionshop/screens/my_purchase/my_purchase_view.dart';
import 'package:fashionshop/screens/product_search/product_search_view.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({
    super.key,
    required this.viewModel,
    this.loginRequested,
    this.logoutRequested,
  });
  final HomeViewModel viewModel;
  final Function()? loginRequested;
  final Function()? logoutRequested;

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
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: _loggedIn(context: context, userProfile: viewModel.userProfile),
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
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: AccountBannerWidget(
            userProfile: userProfile,
            onClickLogin: loginRequested,
            onClickViewProfile: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AccountProfileView(token: viewModel.tokenKey!),
                ),
              );
            },
          ),
        ),
        wideButton(
          // TODO: Add more item like In progress, deliveried,...)
          text: "My Purchases",
          iconData: Icons.assignment_outlined,
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyPurchaseView(token: viewModel.tokenKey!),
              ),
            );
          },
        ),
        wideButton(
          text: "Vouchers",
          iconData: Icons.confirmation_number_outlined,
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          onClick: () {},
        ),
        wideButton(
          text: "Help Center",
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          iconData: Icons.support_agent,
          onClick: () {},
        ),
        wideButton(
          text: "App Settings",
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          iconData: Icons.settings_outlined,
          onClick: () {},
        ),
        wideButton(
          text: "Logout",
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          iconData: Icons.logout,
          onClick: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 16),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (logoutRequested != null) {
                      logoutRequested!();
                    }
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
