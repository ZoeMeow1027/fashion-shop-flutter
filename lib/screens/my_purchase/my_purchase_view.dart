import 'package:flutter/material.dart';

import '../account_login/components/show_snackbar_msg.dart';
import 'components/history_item_widget.dart';
import 'components/view_model.dart';

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
  late ViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ViewModel(tokenKey: widget.token);
    _viewModel.addListener(() {
      setState(() {});
    });
    _viewModel.getCartHistory(onDone: () {
      showSnackbarMessage(context: context, msg: "Done!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Purchase"),
      ),
      body: Column(
        children: List.generate(
          _viewModel.cartHistoryList.length,
          (index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: HistoryItemWidget(
                    cartItem: _viewModel.cartHistoryList[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
