import 'package:flutter/material.dart';

import '../../config/variables.dart';
import '../../model/cart_history_item.dart';
import '../../repository/product_api.dart';
import '../components/custom_button.dart';
import '../components/order_list_widget.dart';
import '../components/price_showcase_widget.dart';
import '../product_details/product_details_view.dart';
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
            OrderListWidget(
              label: "Your cart in this delivery:",
              productList: cartHistoryItem.cartList,
              onClickItem: (id) {
                // TODO: Replace for call from id here!
                ProductAPI.getProducts().then((value) {
                  if (value == null) {
                    return;
                  }
                  final product = value.where((p0) => p0.id == id);

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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                ),
                child: PriceShowcaseWidget(
                  padding: const EdgeInsets.only(top: 10),
                  priceTotalCart: cartHistoryItem.cartList
                      .fold<double>(0, (sum, item) => sum + item.price),
                  priceTax: cartHistoryItem.taxPrice,
                  priceShip: cartHistoryItem.shipPrice,
                  priceTotalAmount: cartHistoryItem.totalPrice,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                ),
                child: TimeAndAddressDetailsWidget(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  paidAt: cartHistoryItem.paidAt,
                  deliveriedAt: cartHistoryItem.deliveredAt,
                  shippingAddress: cartHistoryItem.shippingAddress,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 65,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cartHistoryItem.paidAt != null
                    ? const Text("")
                    : CustomButton(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        label: "Re-create payment",
                        verticalPadding: 0,
                        fillColor: true,
                        onClick: () {},
                      ),
                CustomButton(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  label: "Need help?",
                  fillColor: true,
                  verticalPadding: 0,
                  onClick: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
