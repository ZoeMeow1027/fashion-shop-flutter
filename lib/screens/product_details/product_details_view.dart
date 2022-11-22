import 'package:fashionshop/model/product_item.dart';
import 'package:fashionshop/screens/product_details/components/order_actions_bar.dart';
import 'package:fashionshop/screens/product_details/components/current_state.dart';
import 'package:fashionshop/screens/product_details/components/basic_information.dart';
import 'package:fashionshop/screens/product_search/product_search_view.dart';
import 'package:flutter/material.dart';

import 'components/order_options.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productItem,
  });

  final ProductItem productItem;

  @override
  State<StatefulWidget> createState() => _ProductDetailsView();
}

class _ProductDetailsView extends State<ProductDetailsView> {
  final List<int> availableColors = [
    Colors.blue.value,
    Colors.red.value,
    Colors.black.value,
    Colors.pink.value,
    Colors.purple.value,
    Colors.green.value,
    Colors.lightBlue.value,
    Colors.lightGreen.value,
    Colors.yellow.value,
    Colors.amber.value,
  ];

  final List<String> previewLink = [
    'https://www.pngall.com/wp-content/uploads/2018/04/Clothing-PNG-File.png',
    'https://www.transparentpng.com/thumb/clothes-png/RB9gy1-clothes-simple.png',
    'https://www.freepnglogos.com/uploads/garments-png/plain-powder-blue-women-polo-shirt-cutton-garments-40.png',
    'http://clipart-library.com/newimages/clothes-clip-art-11.png',
    'http://clipart-library.com/images/E6TpBqGiE.png',
    'http://clipart-library.com/img/1781833.png',
  ];

  final List<String> availableSize = ['S', 'M', 'L', 'XL', 'XXL'];
  final String productName = "Clothes";
  final String productPrice = "\$25.00";
  final double ratingValue = 4.7;
  final bool isFavorited = false;
  final String productDescription =
      """Download Clothing PNG File which is available for personal use. You can also check out the similar PNG images from below gallery. This entry was posted on Monday, April 2nd, 2018 at 11:39 am.

License: Creative Commons 4.0 BY-NC
DMCA: Report

Attribution required, copy the following link on the web where you will be using this image.""";

  late CurrentState currentState;

  @override
  void initState() {
    super.initState();
    currentState = CurrentState();
    currentState.selectedColor = availableColors[0];
    currentState.selectedCount = 1;
    currentState.selectedSizeIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(
        context: context,
        onBackClicked: () {
          Navigator.pop(context);
        },
        onCartClicked: () {
          // TODO: Open your cart
        },
        onSearchClicked: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductSearchView()),
          );
        },
      ),
      body: SingleChildScrollView(child: _appBody(context)),
      bottomNavigationBar: BottomAppBar(
        child: OrderActionsBar(
          context,
          isFavorited: isFavorited,
          addToCartBtnClicked: () {
            // TODO: Add to cart clicked
          },
          favoriteBtnClicked: () {
            // TODO: Send request to add to wishlist
          },
          shareBtnClicked: () {
            // TODO: Share this product links
          },
        ),
      ),
    );
  }

  AppBar _appBar({
    required BuildContext context,
    required void Function()? onBackClicked,
    required void Function()? onSearchClicked,
    required void Function()? onCartClicked,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          if (onBackClicked != null) onBackClicked();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            if (onSearchClicked != null) onSearchClicked();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
          onPressed: () {
            if (onCartClicked != null) onCartClicked();
          },
        ),
      ],
    );
  }

  Widget _appBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicInformation(
            productName: productName,
            productPrice: productPrice,
            previewLink: previewLink,
            ratingValue: ratingValue,
          ),
          OrderOptions(
            availableColors: availableColors,
            availableSize: availableSize,
            inventoryMax: 15,
            currentState: currentState,
            onStateChanged: (state) {
              setState(() {
                currentState = state;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 7.0),
            child: Text(
              productDescription,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
              child: Text(
                "Related Products",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
