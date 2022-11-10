import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductBasicInformation extends StatelessWidget {
  const ProductBasicInformation({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.previewLink,
    required this.ratingValue,
  });

  final String productName;
  final String productPrice;
  final List<String> previewLink;
  final double ratingValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ImagePreview(previewLink: previewLink),
        Text(
          productName,
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        Text(
          productPrice,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        _RatingBar(ratingValue: ratingValue),
      ],
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.previewLink});

  final List<String> previewLink;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: previewLink.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
            child: Image.network(previewLink[index], width: 200, height: 200),
          );
        },
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  const _RatingBar({
    required this.ratingValue,
  });

  final double ratingValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "Rating:",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            RatingBar.builder(
              initialRating: ratingValue,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.blueAccent,
              ),
              onRatingUpdate: (rating) {},
              ignoreGestures: true,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "$ratingValue",
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
