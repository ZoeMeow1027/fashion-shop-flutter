import 'package:fashionshop/screens/home/components/current_state.dart';
import 'package:fashionshop/screens/home/views/account_tab.dart';
import 'package:fashionshop/screens/home/views/home_tab.dart';
import 'package:fashionshop/screens/home/views/wishlist_tab.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CurrentState _currentState;
  late List<NavigationDestination> navBtnList;
  late List<Widget> stateWidgetList;

  @override
  void initState() {
    super.initState();
    _currentState = CurrentState();

    navBtnList = <NavigationDestination>[
      const NavigationDestination(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.favorite),
        label: 'Wishlist',
      ),
      const NavigationDestination(
        icon: Icon(Icons.account_circle),
        label: 'Account',
      ),
    ];

    stateWidgetList = [
      const HomeTab(),
      const WishlistTab(),
      const AccountTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stateWidgetList[_currentState.currentPage],
      bottomNavigationBar: NavigationBarTheme(
        data: Theme.of(context).navigationBarTheme,
        child: NavigationBar(
          destinations: navBtnList,
          selectedIndex: _currentState.currentPage,
          onDestinationSelected: (value) {
            setState(() {
              _currentState.currentPage = value;
            });
          },
        ),
      ),
    );
  }
}
