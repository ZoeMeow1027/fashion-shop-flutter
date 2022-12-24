import 'package:flutter/material.dart';

import '../../../model/user_profile.dart';
import '../../account_profile/account_profile_view.dart';
import '../../components/custom_button.dart';
import '../../contact_support/contact_support_view.dart';
import '../../your_purchase/your_purchase_view.dart';
import 'search_view.dart';
import '../components/account_banner_widget.dart';

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
        CustomButton(
          padding: const EdgeInsets.only(top: 10),
          label: "Your Purchases",
          centerContent: false,
          icon: const Icon(Icons.assignment_outlined),
          verticalPadding: 26,
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
        // CustomButton(
        //   padding: const EdgeInsets.only(top: 10),
        //   label: "Vouchers",
        //   centerContent: false,
        //   icon: Icons.confirmation_number_outlined,
        //   verticalPadding: 26,
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
        CustomButton(
          padding: const EdgeInsets.only(top: 10),
          label: "Contact Support",
          centerContent: false,
          icon: const Icon(Icons.support_agent),
          verticalPadding: 26,
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactSupportView(),
              ),
            );
          },
        ),
        userProfile == null
            ? const Center()
            : CustomButton(
                label: "Logout",
                padding: const EdgeInsets.only(top: 10),
                centerContent: false,
                verticalPadding: 26,
                icon: const Icon(Icons.logout),
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
