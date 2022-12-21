import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import '../../../model/product_item.dart';
import '../../product_details/product_details_view.dart';
import 'product_summary_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    required this.productItemList,
    this.padding = const EdgeInsets.all(0),
    this.showPopularLabel = false,
  });

  final List<ProductItem> productItemList;
  final EdgeInsetsGeometry padding;
  final bool showPopularLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showPopularLabel
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Popular product",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const Center(),
            DynamicHeightGridView(
              itemCount: productItemList.length,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              builder: (ctx, index) {
                return ProductSummaryWidget(
                  productItem: productItemList[index],
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsView(
                          productItem: productItemList[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
