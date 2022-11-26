import 'package:fashionshop/screens/account_login/components/show_snackbar_msg.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
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
        children: [
          _viewModel.cartHistoryList.length > 0
              ? HistoryItemWidget(cartItem: _viewModel.cartHistoryList[0])
              : const Center(),
        ],
      ),
    );
  }
}
