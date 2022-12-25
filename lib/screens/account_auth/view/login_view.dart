import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../config/variables.dart';
import '../../../model/dto/login_dto.dart';
import '../../../repository/user_api.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../../utils/show_snackbar_msg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.onRegisterPage});

  final Function() onRegisterPage;

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isEnabledWidget = true;
  final TextEditingController _cUser = TextEditingController();
  final TextEditingController _cPass = TextEditingController();

  void _clearTextController() {
    _cUser.clear();
    _cPass.clear();
  }

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
                  enabled: _isEnabledWidget,
                  controller: _cUser,
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
                  enabled: _isEnabledWidget,
                  controller: _cPass,
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
                        _clearTextController();
                        widget.onRegisterPage();
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
    if (_cUser.text.length < 6) {
      showSnackbarMessage(
          context: context, msg: 'Username must be at least 6 characters!');
      return;
    }
    if (_cPass.text.length < 3) {
      showSnackbarMessage(
          context: context, msg: 'Password must be at least 3 characters!');
      return;
    }
    if (_isEnabledWidget) {
      setState(() {
        _isEnabledWidget = false;
      });

      showSnackbarMessage(context: context, msg: 'Logging you in...');
      if (await UserAPI.login(LoginDTO.from(
        username: _cUser.text,
        password: _cPass.text,
      ))) {
        // Show snack bar for successful login (this will be deleted in future)
        showSnackbarMessage(context: context, msg: 'Successfully login!');
        // Nav to home view or previous page
        Navigator.pop(context);
      } else {
        // Show snack bar for logging failed!
        setState(() {
          _isEnabledWidget = true;
        });

        showSnackbarMessage(
            context: context,
            msg:
                'Failed while logging you in! Check your username and password, and try again.');
      }
    }
  }
}
