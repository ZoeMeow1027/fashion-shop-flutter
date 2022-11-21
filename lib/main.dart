import 'dart:ui';

import 'package:fashionshop/screens/account_login/login_view.dart';
import 'package:fashionshop/screens/checkout/checkout_view.dart';
import 'package:fashionshop/screens/home/home_view.dart';
import 'package:fashionshop/screens/welcome/welcome_view.dart';
import 'package:fashionshop/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/product_details/product_details_view.dart';

void main() {
  bool welcomePassed;
  SharedPreferences.getInstance().then(
    (value) => {
      welcomePassed = value.getBool("welcomePassed") ?? false,
      runApp(MainApplication(
        welcomePassed: welcomePassed,
      )),
    },
  );
}

class MainApplication extends StatefulWidget {
  MainApplication({
    super.key,
    required this.welcomePassed,
  });
  final bool welcomePassed;
  final ViewModel viewModel = ViewModel();

  @override
  State<MainApplication> createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion Shop',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: widget.welcomePassed
          ? HomeView(viewModel: widget.viewModel)
          : WelcomeView(viewModel: widget.viewModel),
    );
  }
}

// CheckoutView(
//         orderId: 'F348GF843FD22',
//         orderStatus: 1,
//         returnHomeClicked: () {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeView()),
//             (Route<dynamic> route) => false,
//           );
//         },
//       )

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
