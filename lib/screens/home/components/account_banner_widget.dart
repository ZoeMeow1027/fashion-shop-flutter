import 'package:flutter/material.dart';

import '../../../model/user_profile.dart';

class AccountBannerWidget extends StatelessWidget {
  const AccountBannerWidget({
    super.key,
    this.onClickLogin,
    this.onClickViewProfile,
    this.userProfile,
  });

  final UserProfile? userProfile;
  final Function()? onClickLogin;
  final Function()? onClickViewProfile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (userProfile != null) {
          if (onClickViewProfile != null) {
            onClickViewProfile!();
          }
        } else {
          if (onClickLogin != null) {
            onClickLogin!();
          }
        }
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(15),
          color: const Color.fromARGB(255, 231, 208, 0),
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.account_circle_outlined,
          size: 70,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: userProfile != null
                ? [
                    Text(
                      "${userProfile == null ? "" : userProfile!.name}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text(
                      "View profile",
                      style: TextStyle(fontSize: 15),
                    )
                  ]
                : [
                    const Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
          ),
        ),
      ],
    );
  }
}
