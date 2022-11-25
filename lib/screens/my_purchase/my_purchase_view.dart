import 'package:flutter/material.dart';

class MyPurchaseView extends StatefulWidget {
  const MyPurchaseView({
    super.key,
    required this.token,
  });

  final String token;

  @override
  State<StatefulWidget> createState() => _MyPurchaseViewState();
}

class _MyPurchaseViewState extends State<MyPurchaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Purchase"),
      ),
    );
  }
}
