import 'package:fashionshop/screens/product_details/components/app_bar.dart';
import 'package:fashionshop/screens/product_details/components/product_options_bar.dart';
import 'package:fashionshop/screens/product_details/components/current_state.dart';
import 'package:fashionshop/screens/product_details/components/product_basic_information.dart';
import 'package:fashionshop/screens/product_details/components/product_color_selector.dart';
import 'package:fashionshop/screens/product_details/components/product_count_selector.dart';
import 'package:fashionshop/screens/product_details/components/product_size_selector.dart';
import 'package:fashionshop/screens/product_search/product_search_view.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

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
    'https://www.pngall.com/wp-content/uploads/2018/04/Clothing-PNG-File.png',
    'https://www.pngall.com/wp-content/uploads/2018/04/Clothing-PNG-File.png',
    'https://www.pngall.com/wp-content/uploads/2018/04/Clothing-PNG-File.png',
    'https://www.pngall.com/wp-content/uploads/2018/04/Clothing-PNG-File.png',
    'https://www.pngall.com/wp-content/uploads/2018/04/Clothing-PNG-File.png',
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
      appBar: appBar(
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
        child: ProductOptionsBar(
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

  Widget _appBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductBasicInformation(
          productName: productName,
          productPrice: productPrice,
          previewLink: previewLink,
          ratingValue: ratingValue,
        ),
        ProductSizeSelector(
          sizeList: availableSize,
          selectedIndex: currentState.selectedSizeIndex,
          onClickedSize: (sizeSelected) {
            setState(() {
              currentState.selectedSizeIndex = sizeSelected;
            });
          },
        ),
        ProductColorSelector(
          availableColors: availableColors,
          selectedColor: currentState.selectedColor,
          dotSize: 40,
          onClick: (color) {
            var data = currentState;
            data.selectedColor = color;
            setState(() {
              currentState = data;
            });
          },
        ),
        ProductCountSelector(
          count: currentState.selectedCount,
          onChanged: (newCount) {
            var data = currentState;
            data.selectedCount = newCount;
            setState(() {
              currentState = data;
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
        Center(
          child: const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: Text(
              "Related Products",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
