import 'package:flutter/material.dart';

class CurrentStateAccountView {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController reEnterPasswordController;

  late bool rememberLogin;
  late bool isEnabledControl;

  CurrentStateAccountView() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    reEnterPasswordController = TextEditingController();

    rememberLogin = false;
    isEnabledControl = true;
  }

  void clearTextController() {
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    reEnterPasswordController.clear();
  }
}
