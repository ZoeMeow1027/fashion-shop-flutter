import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key, required this.imageList});

  final List<String> imageList;

  @override
  State<StatefulWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.imageList.length,
      itemBuilder: ((context, index, realIndex) {
        return CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageUrl: widget.imageList[index],
          fit: BoxFit.cover,
          alignment: Alignment.center,
        );
      }),
      options: CarouselOptions(
        initialPage: 0,
        viewportFraction: 1,
        height: 250,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
      ),
    );
  }
}