import 'package:fashionshop/screens/product_details/components/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BasicInformation extends StatelessWidget {
  const BasicInformation({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImagePreview(previewLink: previewLink),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                productPrice,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        _ratingBar(ratingValue: ratingValue),
      ],
    );
  }

  Widget _ratingBar({required double ratingValue, double fontSize = 17}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: ratingValue,
              direction: Axis.horizontal,
              itemSize: 30,
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
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
