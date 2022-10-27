import 'dart:ui';

import 'package:fashionshop/view/login_register_view.dart';
import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: LoginView(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
