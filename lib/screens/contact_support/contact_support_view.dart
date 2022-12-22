import 'package:flutter/material.dart';

import '../../config/variables.dart';

class ContactSupportView extends StatelessWidget {
  const ContactSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            isScrollable: false,
            indicatorColor: Variables.mainColor,
            tabs: [
              Tab(text: "FAQ"),
              Tab(text: "Contact Us"),
            ],
          ),
          title: const Text('Contact Support'),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _faqUI(context: context),
            _contactUsUI(context: context),
          ],
        ),
      ),
    );
  }

  Widget _faqUI({required BuildContext context}) {
    return const Icon(Icons.directions_car);
  }

  Widget _contactUsUI({required BuildContext context}) {
    return const Icon(Icons.directions_transit);
  }
}
