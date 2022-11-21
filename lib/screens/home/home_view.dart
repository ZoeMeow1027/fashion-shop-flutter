import 'package:fashionshop/repository/user_api.dart';
import 'package:fashionshop/screens/home/components/current_state.dart';
import 'package:fashionshop/screens/home/views/account_tab.dart';
import 'package:fashionshop/screens/home/views/home_tab.dart';
import 'package:fashionshop/screens/home/views/wishlist_tab.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CurrentState _currentState;
  late List<Widget> stateWidgetList;

  String? tokenKey;

  @override
  void initState() {
    super.initState();
    _currentState = CurrentState();

    stateWidgetList = [
      const HomeTab(),
      const WishlistTab(),
      const AccountTab(),
    ];

    SharedPreferences.getInstance().then(
      (value) => {
        tokenKey = value.getString("tokenKey"),
        () async {
          final isLoggedIn = await UserAPI.isLoggedIn(tokenKey!);
          if (isLoggedIn) {
            value.remove("tokenKey");
          }
        },
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stateWidgetList[_currentState.currentPage],
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
            selectedIndex: _currentState.currentPage,
            onDestinationSelected: (index) => {
              setState(() => {_currentState.currentPage = index})
            },
          ),
        ),
      ),
    );
  }
}
