import 'package:flutter/material.dart';

class OrderActionsBar extends StatelessWidget {
  const OrderActionsBar(
    BuildContext context, {
    super.key,
    this.isFavorited = false,
    required this.onClickAddToCart,
    required this.onClickFavorite,
    required this.onClickShare,
  });

  final bool isFavorited;
  final Function() onClickAddToCart;
  final Function() onClickFavorite;
  final Function() onClickShare;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 10.0, bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: ElevatedButton(
                  onPressed: onClickAddToCart,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromWidth(50),
                  ),
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            //   child: IconButton(
            //     onPressed: favoriteBtnClicked,
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: const Size.fromWidth(50),
            //     ),
            //     icon: Icon(!isFavorited
            //         ? Icons.favorite_outline
            //         : Icons.favorite_outlined),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: IconButton(
                onPressed: onClickShare,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromWidth(50),
                ),
                icon: const Icon(Icons.share),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
