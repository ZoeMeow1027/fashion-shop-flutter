import 'package:flutter/material.dart';

import 'components/current_state_account_view.dart';
import 'view/login_view.dart';
import 'view/register_view.dart';

class AccountAuthorizationView extends StatefulWidget {
  const AccountAuthorizationView({super.key});

  @override
  State<StatefulWidget> createState() => _AccountAuthorizationViewState();
}

class _AccountAuthorizationViewState extends State<AccountAuthorizationView> {
  late PageController _controller;
  late CurrentStateAccountView _state;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _state = CurrentStateAccountView();
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
              state: _state,
              onStateChanged: (state) {
                setState(() {
                  _state = state;
                });
              },
              onRegisterPage: () {
                _controller.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
            ),
            RegisterView(
              state: _state,
              onStateChanged: (state) {
                setState(() {
                  _state = state;
                });
              },
              onLoginPage: () {
                _controller.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
