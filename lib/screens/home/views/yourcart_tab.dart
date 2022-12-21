import 'package:flutter/material.dart';

import '../../../repository/cart_api.dart';
import '../../account_auth/components/show_snackbar_msg.dart';
import '../../checkout_payment/checkout_view.dart';
import 'search_view.dart';
import '../components/product_item_widget.dart';

class YourCartTab extends StatefulWidget {
  const YourCartTab({
    super.key,
    this.tokenKey,
  });
  final String? tokenKey;

  @override
  State<StatefulWidget> createState() => _YourCartTabState();
}

class _YourCartTabState extends State<YourCartTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductSearchView()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: CartAPI.getCart(token: ""),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (!snapshot.hasData) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [Text("No data here!")],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: ProductItemWidget(
                        productItem: snapshot.data![index],
                        onClickDelete: () {
                          return showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Remove this item?'),
                              content: const Text(
                                'Are you sure you want to remove this item from your cart?',
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    CartAPI.removeFromCart(
                                      token: "",
                                      productId:
                                          snapshot.data![index].productId,
                                    );
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            default:
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        onPressed: () async {
          if ((await CartAPI.getCart(token: widget.tokenKey!)).isEmpty) {
            showSnackbarMessage(
                context: context,
                msg:
                    "Your cart is empty! Add a product to cart and come back here when you are ready.");
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutView(token: widget.tokenKey!),
              ),
            );
          }
        },
        isExtended: true,
        label: Row(children: const [
          Icon(Icons.shopping_cart_checkout),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Checkout", style: TextStyle(fontSize: 17)),
          )
        ]),
      ),
    );
  }
}
