import 'package:flutter/material.dart';

class FAQTab extends StatelessWidget {
  const FAQTab({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("FAQ here!"),
          ],
        ),
      ),
    );
  }
}
