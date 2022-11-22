import 'package:fashionshop/screens/account_login/account_authorization_view.dart';
import 'package:fashionshop/screens/home/views/account_tab.dart';
import 'package:fashionshop/screens/home/views/home_tab.dart';
import 'package:fashionshop/screens/home/views/wishlist_tab.dart';
import 'package:fashionshop/screens/home/components/view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Object objKey = Object();

  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    widget.viewModel.checkLoggedIn();
    widget.viewModel.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // _widgetList()[widget.viewModel.currentPage]
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            widget.viewModel.currentPage = page;
          });
        },
        children: [
          HomeTab(viewModel: widget.viewModel),
          const WishlistTab(),
          AccountTab(
            key: ValueKey<Object>(objKey),
            userProfile: widget.viewModel.userProfile,
            loginRequested: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccountAuthorizationView()),
              );
              await widget.viewModel.checkLoggedIn();
              setState(() {
                objKey = Object();
              });
            },
            logoutRequested: () async {
              var prefs = await SharedPreferences.getInstance();
              await prefs.remove("tokenKey");
              setState(() {
                widget.viewModel.tokenKey = null;
                widget.viewModel.userProfile = null;
                objKey = Object();
              });
            },
          ),
        ],
      ),
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
              setState(() {
                // widget.viewModel.currentPage = index;
                controller.jumpToPage(index);
              })
            },
          ),
        ),
      ),
    );
  }
}
