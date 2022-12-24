import 'package:flutter/material.dart';

import '../../config/variables.dart';
import '../../model/user_profile.dart';
import '../../repository/user_api.dart';
import '../account_auth/account_change_pass_view.dart';
import '../../utils/show_snackbar_msg.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class AccountProfileView extends StatefulWidget {
  const AccountProfileView({super.key, required this.token});

  final String token;

  @override
  State<StatefulWidget> createState() => _AccountProfileViewState();
}

class _AccountProfileViewState extends State<AccountProfileView> {
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cUsername = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();

  bool _isEnabledWidget = false;
  String _updateBtnText = "Update Profile";

  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    UserAPI.getProfile(widget.token).then((value) {
      _userProfile = value;
      _cName.text = _userProfile!.name ?? "(unknown)";
      _cUsername.text = _userProfile!.username ?? "(unknown)";
      _cEmail.text = _userProfile!.email ?? "(unknown)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Profile"),
        surfaceTintColor: Variables.mainColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 70,
                ),
              ),
              CustomTextField(
                padding: const EdgeInsets.symmetric(vertical: 6),
                labelText: 'Username',
                enabled: _isEnabledWidget,
                controller: _cUsername,
              ),
              CustomTextField(
                padding: const EdgeInsets.symmetric(vertical: 6),
                labelText: 'Name',
                enabled: _isEnabledWidget,
                controller: _cName,
              ),
              CustomTextField(
                padding: const EdgeInsets.symmetric(vertical: 6),
                labelText: 'Email',
                enabled: _isEnabledWidget,
                controller: _cEmail,
              ),
              CustomButton(
                label: _updateBtnText,
                padding: const EdgeInsets.only(top: 50, bottom: 5),
                fillMaxWidth: true,
                fillColor: true,
                onClick: () {
                  if (_userProfile == null) {
                    return;
                  }
                  if (!_isEnabledWidget) {
                    setState(() {
                      _isEnabledWidget = true;
                      _updateBtnText = "Save Changes";
                    });
                  } else {
                    _navToChangeProfile(
                      context: context,
                      onChanging: () {
                        showSnackbarMessage(
                          context: context,
                          msg: "Changing your profile...",
                        );
                        setState(() {
                          _isEnabledWidget = false;
                        });
                      },
                      onSuccessful: () {
                        showSnackbarMessage(
                          context: context,
                          msg: "Successfully changed your profile information!",
                          clearOld: true,
                        );
                        setState(() {
                          _updateBtnText = "Update Profile";
                        });
                      },
                      onFailed: (data) {
                        showSnackbarMessage(
                          context: context,
                          msg: "Failed while changing your profile: $data",
                        );
                        setState(() {
                          _isEnabledWidget = true;
                        });
                      },
                    );
                  }
                },
              ),
              _isEnabledWidget
                  ? CustomButton(
                      label: "Discard Changes",
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      fillMaxWidth: true,
                      fillColor: true,
                      onClick: () {
                        _resetProfileValue(context: context);
                      },
                    )
                  : const Center(),
              CustomButton(
                label: "Change Password",
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                fillMaxWidth: true,
                fillColor: true,
                onClick: () {
                  if (_userProfile == null) {
                    return;
                  }
                  _navToChangePass(context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navToChangePass({required BuildContext context}) {
    if (_isEnabledWidget) {
      Navigator.of(context).setState(() {
        _isEnabledWidget = false;
        _updateBtnText = "Update Profile";
      });
    }
    _resetProfileValue(context: context);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AccountChangePassView(
          username:
              (_userProfile == null) ? "(unknown)" : _userProfile!.username,
          token: widget.token,
        ),
      ),
    );
  }

  void _resetProfileValue({required BuildContext context}) {
    setState(() {
      _isEnabledWidget = false;
      _updateBtnText = "Update Profile";
      _cUsername.text =
          _userProfile == null ? "(unknown)" : _userProfile!.username!;
      _cName.text = _userProfile == null ? "(unknown)" : _userProfile!.name!;
      _cEmail.text = _userProfile == null ? "(unknown)" : _userProfile!.email!;
    });
  }

  Future<void> _navToChangeProfile({
    required BuildContext context,
    Function()? onChanging,
    Function()? onSuccessful,
    Function(String)? onFailed,
  }) async {
    try {
      if (onChanging != null) {
        onChanging();
      }
      await UserAPI.updateProfile(
        token: widget.token,
        profile: UserProfile.fromJson({
          "id": 0,
          "username": _cUsername.text,
          "name": _cName.text,
          "email": _cEmail.text,
        }),
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
