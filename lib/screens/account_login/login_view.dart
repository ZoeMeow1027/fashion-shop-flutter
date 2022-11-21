import 'package:fashionshop/repository/user_api.dart';
import 'package:fashionshop/screens/account_login/register_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'components/custom_outlined_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberLogin = false;
  bool isEnabledControl = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("")),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 25, left: 25, right: 25),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    child: customOutlinedTextField(
                        text: 'Username',
                        enabled: isEnabledControl,
                        controller: usernameController),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    child: customOutlinedTextField(
                        text: 'Password',
                        enabled: isEnabledControl,
                        controller: passwordController),
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
                  if (isEnabledControl) {
                    setState(() {
                      isEnabledControl = false;
                    });
                    _showSnackbarMessage(msg: 'Logging you in...');
                    if (await UserAPI.login(
                        usernameController.text, passwordController.text)) {
                      // Show snackbar for successful login (this will be deleted in future)
                      _showSnackbarMessage(msg: 'Successfully log you in!');
                      // Nav to home view or previous page
                      Navigator.pop(context);
                    } else {
                      // Show snackbar for logging failed!
                      setState(() {
                        isEnabledControl = true;
                      });
                      _showSnackbarMessage(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterView()),
                            );
                          },
                      ),
                    ],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbarMessage({
    required String msg,
    bool clearOld = true,
  }) {
    if (clearOld) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
