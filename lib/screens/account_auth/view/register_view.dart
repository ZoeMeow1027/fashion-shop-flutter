import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../config/variables.dart';
import '../../../model/dto/register_dto.dart';
import '../../../repository/user_api.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../../utils/show_snackbar_msg.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    required this.onLoginPage,
  });

  final Function() onLoginPage;

  @override
  State<StatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isEnabledWidget = true;
  final TextEditingController _cUserName = TextEditingController(),
      _cEmail = TextEditingController(),
      _cPass = TextEditingController(),
      _cRePass = TextEditingController();

  void _clearTextController() {
    _cUserName.clear();
    _cPass.clear();
    _cEmail.clear();
    _cRePass.clear();
  }

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
                  enabled: _isEnabledWidget,
                  controller: _cUserName,
                  prefixIcon: const Icon(Icons.person),
                ),
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Email',
                  enabled: _isEnabledWidget,
                  controller: _cEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Password',
                  enabled: _isEnabledWidget,
                  controller: _cPass,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.password),
                ),
                CustomTextField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  labelText: 'Re-enter password',
                  enabled: _isEnabledWidget,
                  controller: _cRePass,
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
                name: _cUserName.text,
                email: _cEmail.text,
                password: _cPass.text,
                reEnterPassword: _cRePass.text,
                onRequesting: () {
                  setState(() {
                    _isEnabledWidget = false;
                  });
                  showSnackbarMessage(
                    context: context,
                    msg: 'Registring you to server, please wait...',
                    duration: const Duration(minutes: 5),
                  );
                },
                onSuccessful: () {
                  showSnackbarMessage(
                      context: context,
                      msg:
                          'Successfully register! Your account is now ready to use.');
                  setState(() {
                    _isEnabledWidget = false;
                  });
                  Navigator.pop(context);
                },
                onFailed: (data) {
                  setState(() {
                    _isEnabledWidget = true;
                  });
                  showSnackbarMessage(
                      context: context,
                      msg: 'Failed while register you ($data)');
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
                        _clearTextController();
                        widget.onLoginPage();
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
