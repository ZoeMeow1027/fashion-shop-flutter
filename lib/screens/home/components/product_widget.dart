import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionshop/model/product_item.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productItem,
    this.onClick,
  });

  final ProductItem productItem;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    log("triggered");

    return InkWell(
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
            CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: "http://127.0.0.1:8000${productItem.imageUrl}",
              width: 300,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${productItem.name}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Rating: ${productItem.rating}",
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
    );
  }
}
