import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_button.dart';
import '../home/home_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      // decoration: BoxDecoration(
      //   image: const DecorationImage(
      //     image: AssetImage("assets/img/bg-welcome.jpg"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: 2,
            itemBuilder: ((context, index, realIndex) {
              String data = "";
              switch (index) {
                case 0:
                  data = "assets/img/bg_welcome_1.png";
                  break;
                case 1:
                  data = "assets/img/bg_welcome_2.png";
                  break;
                default:
                  break;
              }
              return Image(
                image: AssetImage(data),
                fit: BoxFit.fitWidth,
                height: double.infinity,
                width: double.infinity,
              );
            }),
            options: CarouselOptions(
              initialPage: 0,
              viewportFraction: 1,
              height: double.infinity,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: CustomButton(
              label: "Get Started",
              fillColor: true,
              onClick: () {
                SharedPreferences.getInstance().then(
                  (value) => {
                    value.setBool("welcomePassed", true),
                  },
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
