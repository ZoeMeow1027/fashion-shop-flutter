import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    50), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text("Awesome! Let's continue!"),
            ),
          ),
        ],
      ),
    );
  }
}
