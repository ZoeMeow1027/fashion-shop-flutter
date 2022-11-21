import 'package:fashionshop/model/dto/register_dto.dart';
import 'package:fashionshop/repository/user_api.dart';
import 'package:fashionshop/screens/account_login/components/current_state_account_view.dart';
import 'package:fashionshop/screens/account_login/components/custom_outlined_text_field.dart';
import 'package:fashionshop/screens/account_login/components/show_snackbar_msg.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onLoginPage,
  });

  final CurrentStateAccountView state;
  final Function(CurrentStateAccountView) onStateChanged;
  final Function() onLoginPage;

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
                "Create Account",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Text(
                "Getting started by create an account!",
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
                  text: 'Name',
                  controller: state.usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: customOutlinedTextField(
                  text: 'Email',
                  controller: state.emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: customOutlinedTextField(
                  isPassword: true,
                  text: 'Password',
                  controller: state.passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: customOutlinedTextField(
                  isPassword: true,
                  text: 'Re-enter password',
                  controller: state.reEnterPasswordController,
                ),
              ),
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
              if (state.passwordController.text.length < 6) {
                showSnackbarMessage(
                    context: context,
                    msg: 'Password must be at least 6 characters!');
                return;
              }
              if (state.passwordController.text !=
                  state.reEnterPasswordController.text) {
                showSnackbarMessage(
                    context: context,
                    msg:
                        'Your re-enter password must be the same your password!');
                return;
              }
              if (state.isEnabledControl) {
                state.isEnabledControl = false;
                onStateChanged(state);
                showSnackbarMessage(context: context, msg: 'Registering...');
                if (await UserAPI.register(RegisterDTO.from(
                  name: state.usernameController.text,
                  email: state.emailController.text,
                  password: state.passwordController.text,
                ))) {
                  // Show snackbar for successful login (this will be deleted in future)
                  showSnackbarMessage(
                      context: context, msg: 'Successfully register!');
                  // Nav to home view or previous page
                  Navigator.pop(context);
                } else {
                  // Show snackbar for logging failed!
                  state.isEnabledControl = true;
                  onStateChanged(state);
                  showSnackbarMessage(
                      context: context,
                      msg:
                          'Failed while register! Check your internet and try again.');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(
                  50), // fromHeight use double.infinity as width and 40 is the height
            ),
            child: const Text("Create account"),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Have an account? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Return to login!',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Login view here!
                        state.clearTextController();
                        onLoginPage();
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
