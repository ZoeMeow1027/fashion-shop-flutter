import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/urls.dart';
import '../../config/variables.dart';
import '../../model/product_item.dart';
import '../../repository/cart_api.dart';
import '../account_auth/account_auth_view.dart';
import '../../utils/show_snackbar_msg.dart';
import '../home/views/search_view.dart';
import 'components/basic_information.dart';
import 'components/order_actions_bar.dart';
import 'components/order_options.dart';
import 'components/review_summary_widget.dart';
import 'views/review_all_view.dart';

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

  int _selectedColorIndex = 0;
  int _selectedCount = 0;
  int _selectedSizeIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (availableColors != null) {
        _selectedColorIndex = availableColors![0];
      }
      _selectedCount = 1;
      _selectedSizeIndex = 0;
    });
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
          onClickAddToCart: () async {
            await _addToCart(context: context);
          },
          onClickFavorite: () {},
          onClickShare: () async {
            await Share.share(
              "${Urls.urlBase}${Urls.urlGetProducts}${widget.productItem.id}/",
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
      backgroundColor: Colors.transparent,
      surfaceTintColor: Variables.mainColor,
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
            // previewLink: ["${Urls.urlBase}${widget.productItem.imageUrl!}"],
            previewLink: ["${widget.productItem.imageUrl!}"],
            ratingValue: widget.productItem.rating,
            ratingCount: widget.productItem.reviewNum,
          ),
          OrderOptions(
            availableColors: availableColors,
            availableSize: availableSize,
            inventoryMax: widget.productItem.countInStock,
            selectedSizeIndex: _selectedSizeIndex,
            selectedColorIndex: _selectedColorIndex,
            currentCount: _selectedCount,
            onStateChanged: (size, color, count) {
              setState(() {
                _selectedSizeIndex != size ? _selectedSizeIndex = size : () {};
                _selectedColorIndex != color
                    ? _selectedColorIndex = color
                    : () {};
                _selectedCount != count ? _selectedCount = count : () {};
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 7.0),
            child: Text(
              "${widget.productItem.description}",
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ReviewSummaryWidget(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 25, bottom: 15),
            reviewList: widget.productItem.reviewList,
            showShowAllBtn: true,
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReviewAllView(
                    reviewList: widget.productItem.reviewList,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addToCart({required BuildContext context}) async {
    var prefs = await SharedPreferences.getInstance();
    var tokenKey = prefs.getString("tokenKey");
    if (tokenKey == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AccountAuthorizationView(),
        ),
      );
      return;
    }
    try {
      showSnackbarMessage(
        context: context,
        msg: "Adding this product to your cart...",
        clearOld: true,
      );
      await CartAPI.addToCart(
        token: "",
        productId: widget.productItem.id!,
        count: _selectedCount,
      );
      showSnackbarMessage(
        context: context,
        msg: "Successfully added this product to your cart.",
        clearOld: true,
      );
    } catch (ex) {
      showSnackbarMessage(
        context: context,
        msg:
            "We ran a issue while adding this product to your cart. Check your internet connection and try again.",
        clearOld: true,
      );
    }
  }
}
