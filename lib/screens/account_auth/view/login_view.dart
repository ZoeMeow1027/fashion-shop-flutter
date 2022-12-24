import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../config/variables.dart';
import '../../../model/dto/login_dto.dart';
import '../../../repository/user_api.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../components/current_state_account_view.dart';
import '../components/show_snackbar_msg.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onRegisterPage,
  });

  final CurrentStateAccountView state;
  final Function(CurrentStateAccountView) onStateChanged;
  final Function() onRegisterPage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Sign in to continue!",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 156, 158, 163)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Username',
                  enabled: state.isEnabledControl,
                  controller: state.usernameController,
                  prefixIcon: const Icon(Icons.person),
                  onSubmitted: (value) async {
                    await _loginClicked(context: context);
                  },
                ),
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Password',
                  isPassword: true,
                  enabled: state.isEnabledControl,
                  controller: state.passwordController,
                  prefixIcon: const Icon(Icons.password),
                  onSubmitted: (value) async {
                    await _loginClicked(context: context);
                  },
                ),
                // CheckboxListTile(
                //   title: const Text("Remember me?"),
                //   value: rememberLogin,
                //   onChanged: (newValue) {
                //     setState(() {
                //       rememberLogin = !rememberLogin;
                //     });
                //   },
                // ),
              ],
            ),
          ),
          CustomButton(
            padding: const EdgeInsets.only(top: 50, bottom: 15),
            label: "Login",
            fillColor: true,
            fillMaxWidth: true,
            onClick: () async {
              await _loginClicked(context: context);
            },
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 15),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Forgot your password?',
                    style: const TextStyle(
                      color: Variables.mainColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Forgot your account?
                      },
                  ),
                ],
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(top: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Need an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Create one!',
                    style: const TextStyle(color: Variables.mainColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Register view here!
                        state.clearTextController();
                        onRegisterPage();
                      },
                  ),
                ],
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loginClicked({
    required BuildContext context,
  }) async {
    if (state.usernameController.text.length < 6) {
      showSnackbarMessage(
          context: context, msg: 'Username must be at least 6 characters!');
      return;
    }
    if (state.passwordController.text.length < 3) {
      showSnackbarMessage(
          context: context, msg: 'Password must be at least 3 characters!');
      return;
    }
    if (state.isEnabledControl) {
      state.isEnabledControl = false;
      onStateChanged(state);
      showSnackbarMessage(context: context, msg: 'Logging you in...');
      if (await UserAPI.login(LoginDTO.from(
        username: state.usernameController.text,
        password: state.passwordController.text,
      ))) {
        // Show snack bar for successful login (this will be deleted in future)
        showSnackbarMessage(context: context, msg: 'Successfully login!');
        // Nav to home view or previous page
        Navigator.pop(context);
      } else {
        // Show snack bar for logging failed!
        state.isEnabledControl = true;
        onStateChanged(state);
        showSnackbarMessage(
            context: context,
            msg:
                'Failed while logging you in! Check your username and password, and try again.');
      }
    }
  }
}
