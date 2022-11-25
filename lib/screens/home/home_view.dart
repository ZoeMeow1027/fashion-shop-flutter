import 'package:fashionshop/screens/account_login/account_authorization_view.dart';
import 'package:fashionshop/screens/account_login/components/show_snackbar_msg.dart';
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
    widget.viewModel.checkLoggedIn(onDone: (isLoggedIn) {
      if (!isLoggedIn) {
        showSnackbarMessage(
            context: context, msg: "Session has expired! Please login again.");
      }
    });
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
              color: Color.fromARGB(255, 237, 228, 255),
              width: 2,
            ),
          ),
          color: Colors.transparent,
          child: NavigationBar(
            backgroundColor: Color.fromARGB(255, 237, 228, 255),
            surfaceTintColor: Color.fromARGB(255, 237, 228, 255),
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
