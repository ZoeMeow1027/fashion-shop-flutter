import 'dart:ui';

import 'package:fashionshop/screens/account_login/login_view.dart';
import 'package:fashionshop/screens/checkout/checkout_view.dart';
import 'package:fashionshop/screens/home/home_view.dart';
import 'package:fashionshop/screens/welcome/welcome_view.dart';
import 'package:flutter/material.dart';

import 'screens/product_details/product_details_view.dart';

void main() {
  runApp(const MainApplication());
}

class MainApplication extends StatefulWidget {
  const MainApplication({super.key});

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
      home: const HomeView(),
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
