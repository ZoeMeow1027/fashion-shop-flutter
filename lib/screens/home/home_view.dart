import 'package:fashionshop/screens/home/components/current_state.dart';
import 'package:fashionshop/screens/home/components/search_bar_click.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CurrentState _currentState;
  late List<NavigationDestination> navBtnList;

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
        label: 'Your Cart',
      ),
      const NavigationDestination(
        icon: Icon(Icons.chat),
        label: 'Chat',
      ),
      const NavigationDestination(
        icon: Icon(Icons.account_circle),
        label: 'Account',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SearchBarClick(
              placeholderText: "Search a product",
              onClick: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Search bar clicked!"),
                ));
              },
            ),
          ),
        ),
      ),
      body: const Center(), // TODO: View here!
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
