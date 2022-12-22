import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../config/variables.dart';
import '../../../model/product_review_item.dart';

class ReviewItemWidget extends StatelessWidget {
  const ReviewItemWidget({
    super.key,
    required this.review,
  });

  final ProductReviewItem review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        // border: Border.all(
        //   color: Variables.mainColor,
        //   width: 2,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  review.rating == null
                      ? const Text("Not rating yet")
                      : RatingBar.builder(
                          initialRating: review.rating!,
                          direction: Axis.horizontal,
                          itemSize: 20,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Variables.mainColor,
                          ),
                          onRatingUpdate: (rating) {},
                          ignoreGestures: true,
                        ),
                  const Spacer(),
                  Text(
                    review.createAt == null
                        ? "(Unknown date)"
                        : DateFormat("dd/MM/yyyy HH:mm")
                            .format(review.createAt!),
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  review.comment ?? "(no more comment)",
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
