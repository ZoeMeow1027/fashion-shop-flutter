import 'package:flutter/material.dart';

import '../../components/custom_button.dart';

class ContactUsTab extends StatelessWidget {
  const ContactUsTab({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          CustomButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            verticalPadding: 30,
            label: "Customer Service",
            centerContent: false,
            shadowEnabled: true,
            borderEnabled: false,
            icon: const Icon(Icons.headset_mic_outlined),
            onClick: () {},
          ),
          CustomButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            verticalPadding: 30,
            label: "Website",
            centerContent: false,
            shadowEnabled: true,
            borderEnabled: false,
            icon: const Icon(Icons.public),
            onClick: () {},
          ),
          CustomButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            verticalPadding: 30,
            label: "Facebook",
            centerContent: false,
            shadowEnabled: true,
            borderEnabled: false,
            icon: const Icon(Icons.facebook),
            onClick: () {},
          ),
          CustomButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            verticalPadding: 30,
            label: "Twitter",
            centerContent: false,
            shadowEnabled: true,
            borderEnabled: false,
            imageIcon: const ImageIcon(AssetImage("assets/icons/twitter.png")),
            onClick: () {},
          ),
          CustomButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            verticalPadding: 30,
            label: "Instagram",
            centerContent: false,
            shadowEnabled: true,
            borderEnabled: false,
            imageIcon:
                const ImageIcon(AssetImage("assets/icons/instagram.png")),
            onClick: () {},
          ),
        ],
      ),
    );
  }
}
