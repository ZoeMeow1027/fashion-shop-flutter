import 'package:flutter/material.dart';

import '../../../model/product_item.dart';
import '../../components/custom_cache_network_image.dart';

class ProductSummaryWidget extends StatelessWidget {
  const ProductSummaryWidget({
    super.key,
    required this.productItem,
    this.onClick,
  });

  final ProductItem productItem;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          if (onClick != null) {
            onClick!();
          }
        },
        child: Container(
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCacheNetworkImage(
                imageUrl: "${productItem.imageUrl}",
                width: 300,
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${productItem.name}",
                        style: const TextStyle(fontSize: 18)),
                    Text(
                        productItem.rating == null
                            ? "No rating yet"
                            : "Rating: ${productItem.rating}",
                        style: const TextStyle(fontSize: 15)),
                    Text(
                      "${productItem.price}\$",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
