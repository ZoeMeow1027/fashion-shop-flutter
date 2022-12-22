import 'package:flutter/material.dart';

import '../../config/variables.dart';
import '../../model/cart_history_item.dart';
import '../../repository/product_api.dart';
import '../product_details/product_details_view.dart';
import 'components/bottom_action_bar.dart';
import 'components/price_details_widget.dart';
import 'components/product_list_widget.dart';
import 'components/header_widget.dart';
import 'components/time_and_address_details_widget.dart';

class MyPurchaseDetailView extends StatelessWidget {
  const MyPurchaseDetailView({
    super.key,
    required this.cartHistoryItem,
  });

  final CartHistoryItem cartHistoryItem;
  final Color _color = Variables.mainColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: _color),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(
              bgColor: _color,
              date: cartHistoryItem.createdAt,
              deliveryId: cartHistoryItem.id,
              status: cartHistoryItem.paidAt == null
                  ? "Waiting for payment"
                  : cartHistoryItem.deliveredAt == null
                      ? "Done payment, waiting for delivery"
                      : "Completed",
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Your cart in this delivery:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            ProductListWidget(
              productList: cartHistoryItem.cartList,
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 0),
              onClick: (productId) {
                // TODO: Replace here!
                ProductAPI.getProducts().then((value) {
                  if (value == null) {
                    return;
                  }
                  final product = value.where((p0) => p0.id == productId);

                  if (product.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsView(
                            productItem: product.elementAt(0)),
                      ),
                    );
                  } else {}
                });
              },
            ),
            PriceDetailsWidget(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              basePrice: cartHistoryItem.cartList
                  .fold<double>(0, (sum, item) => sum + item.price),
              taxPrice: cartHistoryItem.taxPrice,
              shipPrice: cartHistoryItem.shipPrice,
              totalPrice: cartHistoryItem.totalPrice,
            ),
            TimeAndAddressDetailsWidget(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              paidAt: cartHistoryItem.paidAt,
              deliveriedAt: cartHistoryItem.deliveredAt,
              shippingAddress: cartHistoryItem.shippingAddress,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        isPaid: cartHistoryItem.paidAt != null,
        onClickPayment: () {},
        onClickContact: () {},
      ),
    );
  }
}
