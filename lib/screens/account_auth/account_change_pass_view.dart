import 'package:flutter/material.dart';

import '../../repository/user_api.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import 'components/show_snackbar_msg.dart';

class AccountChangePassView extends StatefulWidget {
  const AccountChangePassView({
    super.key,
    required this.token,
    this.username,
  });

  final String token;
  final String? username;

  @override
  State<StatefulWidget> createState() => _AccountChangePassViewState();
}

class _AccountChangePassViewState extends State<AccountChangePassView> {
  bool _isEnabledWidget = true;
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _reEnterPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Change your password",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.username ?? "(Unknown)",
                      style: const TextStyle(
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      isPassword: true,
                      labelText: 'Current Password',
                      enabled: _isEnabledWidget,
                      controller: _oldPassController,
                    ),
                    CustomTextField(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      isPassword: true,
                      labelText: 'New password',
                      enabled: _isEnabledWidget,
                      controller: _newPassController,
                    ),
                    CustomTextField(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      isPassword: true,
                      labelText: 'Re-enter new password',
                      enabled: _isEnabledWidget,
                      controller: _reEnterPassController,
                    ),
                  ],
                ),
              ),
              CustomButton(
                padding: const EdgeInsets.only(top: 40, bottom: 15),
                fillColor: true,
                fillMaxWidth: true,
                label: "Change Password",
                labelSize: 17,
                onClick: () {
                  _changePassword(
                    context: context,
                    token: widget.token,
                    oldPassword: _oldPassController.text,
                    newPassword: _newPassController.text,
                    reEnterPassword: _reEnterPassController.text,
                    onStart: () {
                      Navigator.of(context).setState(() {
                        _isEnabledWidget = false;
                      });
                      showSnackbarMessage(
                        context: context,
                        msg: "Changing your password",
                        duration: const Duration(minutes: 5),
                      );
                    },
                    onSuccessful: () {
                      Navigator.of(context).setState(() {
                        _isEnabledWidget = true;
                      });
                      showSnackbarMessage(
                        context: context,
                        msg: "Successfully changed your password!",
                      );
                      Navigator.pop(context);
                    },
                    onFailed: (data) {
                      Navigator.of(context).setState(() {
                        _isEnabledWidget = true;
                      });
                      showSnackbarMessage(
                        context: context,
                        msg: "Failed while changing your password: $data",
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword({
    required BuildContext context,
    required String token,
    required String oldPassword,
    required String newPassword,
    required String reEnterPassword,
    Function()? onStart,
    Function()? onSuccessful,
    Function(String)? onFailed,
  }) async {
    // If new password and re-enter password aren't same, raise exception here.
    if (newPassword != reEnterPassword) {
      if (onFailed != null) {
        onFailed("Your new password and re-enter new password aren't same!");
      }
      return;
    }

    if (onStart != null) {
      onStart();
    }

    try {
      await UserAPI.changePassword(
        token: widget.token,
        oldPassword: _oldPassController.text,
        newPassword: _newPassController.text,
      );
      if (onSuccessful != null) {
        onSuccessful();
      }
    } catch (ex) {
      if (onFailed != null) {
        onFailed(ex.toString());
      }
    }
  }
}
