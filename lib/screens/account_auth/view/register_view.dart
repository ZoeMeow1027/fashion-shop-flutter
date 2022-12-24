import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../config/variables.dart';
import '../../../model/dto/register_dto.dart';
import '../../../repository/user_api.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../components/current_state_account_view.dart';
import '../components/show_snackbar_msg.dart';

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
    return SingleChildScrollView(
      child: Column(
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
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Name',
                  enabled: state.isEnabledControl,
                  controller: state.usernameController,
                  prefixIcon: const Icon(Icons.person),
                ),
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Email',
                  enabled: state.isEnabledControl,
                  controller: state.emailController,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Password',
                  enabled: state.isEnabledControl,
                  controller: state.passwordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.password),
                ),
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Re-enter password',
                  enabled: state.isEnabledControl,
                  controller: state.reEnterPasswordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.password),
                ),
              ],
            ),
          ),
          CustomButton(
            label: "Create Account",
            padding: const EdgeInsets.only(top: 40, bottom: 15),
            fillMaxWidth: true,
            fillColor: true,
            onClick: () async {
              await _createAccount(
                context: context,
                name: state.usernameController.text,
                email: state.emailController.text,
                password: state.passwordController.text,
                reEnterPassword: state.reEnterPasswordController.text,
                onRequesting: () {
                  state.isEnabledControl = false;
                  showSnackbarMessage(
                    context: context,
                    msg: 'Registring you to server, please wait...',
                    duration: const Duration(minutes: 5),
                  );
                },
                onSuccessful: () {
                  showSnackbarMessage(
                      context: context, msg: 'Successfully register!');
                  state.isEnabledControl = false;
                  Navigator.pop(context);
                },
                onFailed: (data) {
                  showSnackbarMessage(
                      context: context,
                      msg: 'Failed while register you ($data)');
                  state.isEnabledControl = true;
                },
              );
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(top: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Have an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Return to login!',
                    style: const TextStyle(color: Variables.mainColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Register view here!
                        state.clearTextController();
                        onLoginPage();
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

  Future<void> _createAccount({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String reEnterPassword,
    Function()? onRequesting,
    Function()? onSuccessful,
    Function(String)? onFailed,
  }) async {
    void sendFail(String data) {
      if (onFailed != null) {
        onFailed(data);
        return;
      }
    }

    if (name.length < 6) {
      sendFail("Username must be at least 6 characters!");
    }
    if (password.length < 6) {
      sendFail("Password must be at least 6 characters!");
    }
    if (password != reEnterPassword) {
      sendFail('Your re-enter password must be the same your password!');
    }

    if (onRequesting != null) {
      onRequesting();
    }

    try {
      await UserAPI.register(RegisterDTO.from(
        name: name,
        email: email,
        password: password,
      ));

      if (onSuccessful != null) {
        onSuccessful();
      }
    } catch (ex) {
      sendFail(ex.toString());
    }
  }
}
