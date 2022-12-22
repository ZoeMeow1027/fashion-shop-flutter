import 'package:flutter/material.dart';

class BannerStaticWidget extends StatelessWidget {
  const BannerStaticWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/img/bg_banner_home.png"),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          opacity: 0.6,
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "WE ARE FASHION",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "YOU ARE FASHIONISTA",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
