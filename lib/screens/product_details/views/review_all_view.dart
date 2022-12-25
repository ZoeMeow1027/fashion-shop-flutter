import 'package:flutter/material.dart';

import '../../../model/product_review_item.dart';
import '../components/review_summary_widget.dart';

class ReviewAllView extends StatelessWidget {
  const ReviewAllView({
    super.key,
    this.reviewList,
  });

  final List<ProductReviewItem>? reviewList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: ReviewSummaryWidget(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 25),
          reviewList: reviewList,
          titleLabelSize: 34,
        ),
      ),
    );
  }
}
