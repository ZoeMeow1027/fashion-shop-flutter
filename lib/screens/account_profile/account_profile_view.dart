import 'package:flutter/material.dart';

import '../../model/user_profile.dart';
import '../../repository/user_api.dart';
import '../account_auth/account_change_pass_view.dart';

class AccountProfileView extends StatefulWidget {
  const AccountProfileView({super.key, required this.token});

  final String token;

  @override
  State<StatefulWidget> createState() => _AccountProfileViewState();
}

class _AccountProfileViewState extends State<AccountProfileView> {
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cUsername = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();

  late UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    UserAPI.getProfile(widget.token).then((value) {
      _userProfile = value;
      _cName.text = _userProfile!.name ?? "(unknown)";
      _cUsername.text = _userProfile!.username ?? "(unknown)";
      _cEmail.text = _userProfile!.email ?? "(unknown)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Profile")),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.account_circle_outlined,
                size: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
                controller: _cUsername,
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
                controller: _cName,
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                controller: _cEmail,
                readOnly: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _customButton(
                  text: "Update Profile",
                  textColor: Colors.black,
                  onClick: () {},
                  padding: const EdgeInsets.only(left: 5, right: 5),
                ),
                _customButton(
                  text: "Change Password",
                  textColor: Colors.black,
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountChangePassView(
                          username: (_userProfile == null)
                              ? "(unknown)"
                              : _userProfile!.username,
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  padding: const EdgeInsets.only(left: 5, right: 5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton({
    Function()? onClick,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) {
    return Padding(
      padding: padding,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: backgroundColor ?? Colors.blue,
              width: 1.5,
            ),
          ),
        ),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
