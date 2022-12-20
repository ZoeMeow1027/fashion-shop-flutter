import 'package:flutter/material.dart';

import '../../model/cart_history_item.dart';
import '../../repository/order_api.dart';
import '../my_purchase_detail/my_purchase_detail_view.dart';
import 'components/history_item_widget.dart';

class MyPurchaseView extends StatefulWidget {
  const MyPurchaseView({
    super.key,
    required this.token,
  });

  final String token;

  @override
  State<StatefulWidget> createState() => _MyPurchaseViewState();
}

class _MyPurchaseViewState extends State<MyPurchaseView> {
  final List<CartHistoryItem> _cartHistoryList = [];
  bool _cartHistoryListDone = false;

  Future<void> getCartHistory({
    required String tokenKey,
    Function()? onDone,
  }) async {
    _cartHistoryList.clear();
    _cartHistoryList.addAll(await OrderAPI.getCartHistory(tokenKey));

    if (onDone != null) {
      onDone();
    }
  }

  @override
  void initState() {
    super.initState();
    _cartHistoryListDone = false;
    getCartHistory(
      tokenKey: widget.token,
      onDone: () {
        setState(() {
          _cartHistoryListDone = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Purchases")),
      backgroundColor: Colors.white,
      body: !_cartHistoryListDone
          ? Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  _cartHistoryList.length,
                  (index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: HistoryItemWidget(
                          cartItem: _cartHistoryList[index],
                          onClickDeliveryStatus: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyPurchaseDetailView(
                                  cartHistoryItem: _cartHistoryList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
