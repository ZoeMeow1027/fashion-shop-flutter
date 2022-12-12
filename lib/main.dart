import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home/home_view.dart';
import 'screens/welcome/welcome_view.dart';

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
  const MainApplication({
    super.key,
    required this.welcomePassed,
  });
  final bool welcomePassed;

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
      home: widget.welcomePassed ? const HomeView() : const WelcomeView(),
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
