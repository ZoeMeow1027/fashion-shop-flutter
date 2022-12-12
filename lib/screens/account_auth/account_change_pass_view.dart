import 'package:flutter/material.dart';

import 'components/custom_outlined_text_field.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Change your password",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    child: customOutlinedTextField(
                      isPassword: true,
                      text: 'Old password',
                      enabled: _isEnabledWidget,
                      controller: _oldPassController,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    child: customOutlinedTextField(
                      isPassword: true,
                      text: 'New password',
                      enabled: _isEnabledWidget,
                      controller: _newPassController,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    child: customOutlinedTextField(
                      isPassword: true,
                      text: 'Re-enter new password',
                      enabled: _isEnabledWidget,
                      controller: _reEnterPassController,
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
                  setState(() {
                    _isEnabledWidget = false;
                  });
                  // TODO: Change password here!
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                      50), // fromHeight use double.infinity as width and 40 is the height
                ),
                child: const Text("Change password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
