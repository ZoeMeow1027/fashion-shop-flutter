import 'dart:developer';

import 'package:fashionshop/screens/account_login/login_view.dart';
import 'package:fashionshop/screens/home/views/account_tab.dart';
import 'package:fashionshop/screens/home/views/home_tab.dart';
import 'package:fashionshop/screens/home/views/wishlist_tab.dart';
import 'package:fashionshop/view_model/view_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final ViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Object objKey = Object();
  List<Widget> _widgetList() => [
        HomeTab(),
        WishlistTab(),
        AccountTab(
          key: ValueKey<Object>(objKey),
          userProfile: widget.viewModel.userProfile,
          loginRequested: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
            log("triggered");
            await widget.viewModel.checkLoggedIn();
            setState(() {
              objKey = Object();
            });
          },
        ),
      ];

  @override
  void initState() {
    super.initState();
    widget.viewModel.checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetList()[widget.viewModel.currentPage],
      bottomNavigationBar: NavigationBarTheme(
        data: Theme.of(context).navigationBarTheme,
        child: NavigationBarTheme(
          data: Theme.of(context).navigationBarTheme,
          child: NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite),
                label: 'Wishlist',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            selectedIndex: widget.viewModel.currentPage,
            onDestinationSelected: (index) => {
              setState(() => {widget.viewModel.currentPage = index})
            },
          ),
        ),
      ),
    );
  }
}
