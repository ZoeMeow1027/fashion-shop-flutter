import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_profile.dart';
import '../../repository/cart_api.dart';
import '../../repository/user_api.dart';
import '../account_auth/account_auth_view.dart';
import '../../utils/show_snackbar_msg.dart';
import '../components/custom_navbar.dart';
import '../components/custom_navbar_item.dart';
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
      CartAPI.clearCart();
      showSnackbarMessage(
          context: context,
          msg:
              "Session has expired or you are not connected to internet. Please login again.");
    });
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
              await CartAPI.clearCart();
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
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentPage,
        isFilledColor: true,
        onChangedIndex: (index) async {
          switch (index) {
            case 1:
              if (_isLoggedIn) {
                setState(() {
                  _pageController.jumpToPage(index);
                });
              } else {
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
              }
              break;
            default:
              setState(() {
                _pageController.jumpToPage(index);
              });
              break;
          }
        },
        navBarList: const [
          CustomNavBarItem(
            label: "Home",
            iconData: Icons.home,
            isFilledColor: true,
          ),
          CustomNavBarItem(
            label: "Your Cart",
            iconData: Icons.shopping_cart,
            isFilledColor: true,
          ),
          CustomNavBarItem(
            label: "Account",
            iconData: Icons.account_circle,
            isFilledColor: true,
          ),
        ],
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

    if (onDone != null) {
      onDone(true);
    }

    if (_tokenKey == null) {
      await prefs.remove("tokenKey");
    } else if (!(await UserAPI.isLoggedIn(_tokenKey!))) {
      if (reLoginRequested != null) {
        reLoginRequested();
      }
      await prefs.remove("tokenKey");
    } else {
      _userProfile = await UserAPI.getProfile(_tokenKey!);
      isLoggedIn = true;
    }

    if (onDone != null) {
      onDone(isLoggedIn);
    }
  }
}
