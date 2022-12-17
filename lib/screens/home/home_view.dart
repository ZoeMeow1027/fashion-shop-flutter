import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_profile.dart';
import '../../repository/user_api.dart';
import '../account_auth/account_auth_view.dart';
import '../account_auth/components/show_snackbar_msg.dart';
import 'views/account_tab.dart';
import 'views/home_tab.dart';
import 'views/yourcart_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Object _objKey = Object();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn(onDone: (isLoggedIn) {
      setState(() {
        _isLoggedIn = isLoggedIn;
      });
    }, reLoginRequested: () {
      showSnackbarMessage(
          context: context,
          msg:
              "Session has expired or you are not connected to internet. Please login again.");
    });
    // widget.viewModel.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // _widgetList()[widget.viewModel.currentPage]
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          HomeTab(key: ValueKey<Object>(_objKey)),
          YourCartTab(key: ValueKey<Object>(_objKey), tokenKey: _tokenKey),
          AccountTab(
            key: ValueKey<Object>(_objKey),
            tokenKey: _tokenKey,
            userProfile: _userProfile,
            loginRequested: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccountAuthorizationView()),
              );
              await _checkLoggedIn(onDone: (isLoggedIn) {
                setState(() {
                  _isLoggedIn = isLoggedIn;
                  _objKey = Object();
                });
              });
            },
            logoutRequested: () async {
              var prefs = await SharedPreferences.getInstance();
              await prefs.remove("tokenKey");
              setState(() {
                _tokenKey = null;
                _userProfile = null;
                _isLoggedIn = false;
                _objKey = Object();
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          foregroundDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border.all(
              color: const Color.fromARGB(255, 237, 228, 255),
              width: 2,
            ),
          ),
          color: Colors.transparent,
          child: NavigationBar(
            backgroundColor: const Color.fromARGB(255, 237, 228, 255),
            surfaceTintColor: const Color.fromARGB(255, 237, 228, 255),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart),
                label: 'Your Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            selectedIndex: _currentPage,
            onDestinationSelected: (index) {
              switch (index) {
                case 1:
                  if (_isLoggedIn) {
                    setState(() {
                      _pageController.jumpToPage(index);
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountAuthorizationView(),
                      ),
                    );
                  }
                  break;
                default:
                  setState(() {
                    _pageController.jumpToPage(index);
                  });
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  String? _tokenKey;
  UserProfile? _userProfile;

  Future<void> _checkLoggedIn({
    Function(bool)? onDone,
    Function()? reLoginRequested,
  }) async {
    bool isLoggedIn = false;

    final prefs = await SharedPreferences.getInstance();
    _tokenKey = prefs.getString("tokenKey");

    if (_tokenKey == null) {
      await prefs.remove("tokenKey");
    } else if (!(await UserAPI.isLoggedIn(_tokenKey!))) {
      if (reLoginRequested != null) {
        reLoginRequested();
      }
      await prefs.remove("tokenKey");
    } else {
      _userProfile = await UserAPI.getProfile(_tokenKey!);
      log("triggered");
      isLoggedIn = true;
    }

    if (onDone != null) {
      onDone(isLoggedIn);
    }
  }
}
