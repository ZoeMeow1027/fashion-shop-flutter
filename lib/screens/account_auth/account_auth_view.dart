import 'package:flutter/material.dart';

import 'view/login_view.dart';
import 'view/register_view.dart';

class AccountAuthorizationView extends StatefulWidget {
  const AccountAuthorizationView({super.key});

  @override
  State<StatefulWidget> createState() => _AccountAuthorizationViewState();
}

class _AccountAuthorizationViewState extends State<AccountAuthorizationView> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            LoginView(
              onRegisterPage: () {
                _controller.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                );
              },
            ),
            RegisterView(
              onLoginPage: () {
                _controller.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
