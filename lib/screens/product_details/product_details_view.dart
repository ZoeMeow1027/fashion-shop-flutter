import 'package:fashionshop/screens/account_auth/components/show_snackbar_msg.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/configurations.dart';
import '../../model/product_item.dart';
import '../../repository/cart_api.dart';
import '../product_search/product_search_view.dart';
import 'components/basic_information.dart';
import 'components/current_state.dart';
import 'components/order_actions_bar.dart';
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
  final List<int>? availableColors = null;
  final List<String>? availableSize = null;
  final bool isFavorited = false;

  late CurrentState currentState;

  @override
  void initState() {
    super.initState();
    currentState = CurrentState();
    if (availableColors != null) {
      currentState.selectedColor = availableColors![0];
    }
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
          onClickAddToCart: () {
            CartAPI.addToCart(
              token: "",
              productId: widget.productItem.id!,
            ).then((value) {
              showSnackbarMessage(
                context: context,
                msg: "Successfully added this product to your cart.",
              );
            });
            //     .onError((error, stackTrace) {
            //   showSnackbarMessage(
            //     context: context,
            //     msg:
            //         "We ran a issue while adding this product to your cart. Check your internet connection and try again.",
            //   );
            // });
          },
          onClickFavorite: () {},
          onClickShare: () async {
            await Share.share(
              "${Configurations.baseUrl}/api/products/${widget.productItem.id}/",
            );
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
            productName: "${widget.productItem.name}",
            productPrice: "${widget.productItem.price}\$",
            previewLink: [
              "${Configurations.baseUrl}${widget.productItem.imageUrl!}"
            ],
            ratingValue: widget.productItem.rating,
            ratingCount: widget.productItem.reviewNum,
          ),
          OrderOptions(
            availableColors: availableColors,
            availableSize: availableSize,
            inventoryMax: widget.productItem.countInStock,
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
              "${widget.productItem.description}",
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
