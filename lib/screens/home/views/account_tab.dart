import 'package:flutter/material.dart';

import '../../../model/user_profile.dart';
import '../../account_profile/account_profile_view.dart';
import '../../my_purchase/my_purchase_view.dart';
import 'search_view.dart';
import '../components/account_banner_widget.dart';
import '../components/wide_button.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({
    super.key,
    this.tokenKey,
    this.userProfile,
    this.loginRequested,
    this.logoutRequested,
  });
  final String? tokenKey;
  final UserProfile? userProfile;
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
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: _loggedIn(context: context, userProfile: userProfile),
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
                  builder: (context) => AccountProfileView(token: tokenKey!),
                ),
              );
            },
          ),
        ),
        wideButton(
          // TODO: Add more item like In progress, delivered,...)
          text: "Your Purchases",
          iconData: Icons.assignment_outlined,
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          onClick: () {
            if (tokenKey == null) {
              if (loginRequested != null) {
                loginRequested!();
              }
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPurchaseView(token: tokenKey!),
                ),
              );
            }
          },
        ),
        // wideButton(
        //   text: "Vouchers",
        //   iconData: Icons.confirmation_number_outlined,
        //   padding: const EdgeInsets.only(top: 7, bottom: 7),
        //   onClick: () {
        //     if (tokenKey == null) {
        //       if (loginRequested != null) {
        //         loginRequested!();
        //       }
        //     } else {
        //       // TODO: Vouchers
        //     }
        //   },
        // ),
        wideButton(
          text: "Help Center",
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          iconData: Icons.support_agent,
          onClick: () {},
        ),
        userProfile == null
            ? const Center()
            : wideButton(
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
