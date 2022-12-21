import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../components/custom_cache_network_image.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({super.key, required this.previewLink});

  final List<String> previewLink;

  @override
  State<StatefulWidget> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.previewLink.length,
          itemBuilder: ((context, index, realIndex) {
            return CustomCacheNetworkImage(
              imageUrl: widget.previewLink[index],
            );
          }),
          options: CarouselOptions(
            initialPage: _current,
            height: 250,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            onPageChanged: ((index, data) {
              setState(() {
                _current = index;
              });
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "${_current + 1}/${widget.previewLink.length}",
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
