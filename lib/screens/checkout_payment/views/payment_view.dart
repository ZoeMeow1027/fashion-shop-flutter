import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../model/cart_history_item.dart';
import '../../../model/payment_method.dart';
import '../../../repository/paypal_api.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    super.key,
    required this.name,
    required this.shippingAddress,
    required this.subTotal,
    this.taxPercent = 8,
    required this.shippingCost,
    required this.orderList,
    this.paymentMethod = PaymentMethod.PayPal,
    this.onCompleted,
    this.onFailed,
  });

  final String name, paymentMethod;
  final ShippingAddressItem shippingAddress;
  final double taxPercent, subTotal, shippingCost;
  final List<OrderItem> orderList;
  final Function(String)? onCompleted;
  final Function(String)? onFailed;

  @override
  State<StatefulWidget> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late WebViewController _controller;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';
  String? accessToken, checkoutUrl, executeUrl;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController();

    Future.delayed(Duration.zero, () async {
      await _controller.setJavaScriptMode(JavaScriptMode.unrestricted);

      switch (widget.paymentMethod) {
        case PaymentMethod.PayPal:
          await _controller.setNavigationDelegate(_navDelegatePayPal());
          try {
            accessToken = await PayPalAPI.getAccessToken();
            final transactions = _generateJsonPayPal(
              name: widget.name,
              orderList: widget.orderList,
              totalCart: widget.subTotal,
              taxPercent: widget.taxPercent,
              shipCost: widget.shippingCost,
            );
            final res =
                await PayPalAPI.createPaypalPayment(transactions, accessToken);
            if (res != null) {
              setState(() {
                checkoutUrl = res["approvalUrl"];
                executeUrl = res["executeUrl"];
              });
            }
          } catch (e) {
            _navPopWithResult(context: context, result: false);
          }
          await _controller.loadRequest(Uri.parse(checkoutUrl!));
          break;
        // TODO: Payment with MoMo here!
        case PaymentMethod.CoD:
          _navPopWithResult(
            context: context,
            result: true,
          );
          break;
        default:
          _navPopWithResult(
            context: context,
            result: false,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("Completing Payment - ${widget.paymentMethod}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            if (widget.onFailed != null) {
              widget.onFailed!("");
            }
          },
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  NavigationDelegate _navDelegatePayPal() {
    return NavigationDelegate(
      onNavigationRequest: (request) {
        if (request.url.contains(returnURL)) {
          final uri = Uri.parse(request.url);
          final payerID = uri.queryParameters['PayerID'];
          if (payerID != null) {
            PayPalAPI.executePayment(executeUrl, payerID, accessToken)
                .then((id) {
              _navPopWithResult(
                context: context,
                result: true,
                data: id,
              );
            }).onError((error, stackTrace) {
              _navPopWithResult(context: context, result: false);
            });
          } else {
            _navPopWithResult(context: context, result: false);
          }
        }
        if (request.url.contains(cancelURL)) {
          _navPopWithResult(context: context, result: false);
        }
        return NavigationDecision.navigate;
      },
    );
  }

  void _navPopWithResult({
    required BuildContext context,
    required bool result,
    String? data,
  }) {
    Navigator.pop(context);
    if (result) {
      if (widget.onCompleted != null) {
        widget.onCompleted!(data ?? "");
      }
    } else {
      if (widget.onFailed != null) {
        widget.onFailed!(data ?? "");
      }
    }
  }

  Map<String, dynamic> _generateJsonPayPal({
    required String name,
    required List<OrderItem> orderList,
    required double totalCart,
    required double taxPercent,
    required double shipCost,
    String currency = "USD",
  }) {
    double totalAmount =
        widget.subTotal * (100.0 + taxPercent) / 100 + widget.shippingCost;

    List items = List.generate(
        orderList.length,
        (index) => {
              "name": widget.orderList[index].name,
              "quantity": widget.orderList[index].quantity,
              "price": widget.orderList[index].price,
              "currency": currency,
            });

    Map<String, dynamic> data = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": currency,
            "details": {
              "subtotal": widget.subTotal,
              "tax": (widget.subTotal * widget.taxPercent / 100),
              "shipping": widget.shippingCost,
              // "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {"allowed_payment_method": "IMMEDIATE_PAY"},
          "item_list": {
            "items": items,
            "shipping_address": {
              "recipient_name": name,
              // "recipient_name": userFirstName + " " + userLastName,
              "line1": widget.shippingAddress.address,
              "line2": "",
              // "country_code": addressCountry,
              "postal_code": widget.shippingAddress.postalCode,
              // "phone": addressPhoneNumber,
              "state": widget.shippingAddress.city,
              "city": widget.shippingAddress.city,
              "country_code": widget.shippingAddress.country,
            },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL,
      },
    };

    return data;
  }
}
