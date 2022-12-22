import 'package:flutter/material.dart';

import '../../../config/variables.dart';
import '../../../model/product_review_item.dart';
import 'review_item_widget.dart';

class ReviewSummaryWidget extends StatelessWidget {
  const ReviewSummaryWidget({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.reviewList,
    this.maxReviewShow = 3,
    this.titleLabelSize = 22,
    this.showShowAllBtn = false,
    this.onClick,
  });

  final EdgeInsetsGeometry padding;
  final List<ProductReviewItem>? reviewList;
  final int maxReviewShow;
  final double titleLabelSize;
  final bool showShowAllBtn;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reviews & Rating",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: titleLabelSize,
                  ),
                ),
                const Spacer(),
                !showShowAllBtn
                    ? const Center()
                    : InkWell(
                        onTap: () {
                          if (onClick != null) {
                            onClick!();
                          }
                        },
                        child: const Text(
                          "Show all >",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Variables.mainColor,
                          ),
                        ),
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: reviewList == null
                  ? const Text(
                      "No one review yet.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  : reviewList!.isEmpty
                      ? const Text(
                          "No one review yet.",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      : Column(
                          children: List.generate(
                            reviewList!.length <= maxReviewShow
                                ? reviewList!.length
                                : maxReviewShow,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: ReviewItemWidget(
                                review: reviewList![index],
                              ),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
