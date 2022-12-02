import 'package:fashionshop/screens/account_auth/components/current_state_account_view.dart';
import 'package:fashionshop/screens/account_auth/view/login_view.dart';
import 'package:fashionshop/screens/account_auth/view/register_view.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    _controller = PageController();
    _state = CurrentStateAccountView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 25, left: 25, right: 25),
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
        ), // TODO: view data here!
      ),
    );
  }
}
