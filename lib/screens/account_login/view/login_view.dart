import 'package:fashionshop/model/dto/login_dto.dart';
import 'package:fashionshop/repository/user_api.dart';
import 'package:fashionshop/screens/account_login/components/current_state_account_view.dart';
import 'package:fashionshop/screens/account_login/components/custom_outlined_text_field.dart';
import 'package:fashionshop/screens/account_login/components/show_snackbar_msg.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: customOutlinedTextField(
                    text: 'Username',
                    enabled: state.isEnabledControl,
                    controller: state.usernameController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: customOutlinedTextField(
                    isPassword: true,
                    text: 'Password',
                    enabled: state.isEnabledControl,
                    controller: state.passwordController),
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
        Padding(
          padding:
              const EdgeInsets.only(top: 40, bottom: 15, left: 0, right: 0),
          child: ElevatedButton(
            onPressed: () async {
              if (state.usernameController.text.length < 6) {
                showSnackbarMessage(
                    context: context,
                    msg: 'Username must be at least 6 characters!');
                return;
              }
              if (state.passwordController.text.length < 3) {
                showSnackbarMessage(
                    context: context,
                    msg: 'Password must be at least 3 characters!');
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
                  // Show snackbar for successful login (this will be deleted in future)
                  showSnackbarMessage(
                      context: context, msg: 'Successfully login!');
                  // Nav to home view or previous page
                  Navigator.pop(context);
                } else {
                  // Show snackbar for logging failed!
                  state.isEnabledControl = true;
                  onStateChanged(state);
                  showSnackbarMessage(
                      context: context,
                      msg:
                          'Failed while logging you in! Check your username and password, and try again.');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(
                  50), // fromHeight use double.infinity as width and 40 is the height
            ),
            child: const Text("Login"),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Forgot your password?',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // TODO: Forgot your account?
                    },
                ),
              ],
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Need an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Create one!',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Register view here!
                        state.clearTextController();
                        onRegisterPage();
                      },
                  ),
                ],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
