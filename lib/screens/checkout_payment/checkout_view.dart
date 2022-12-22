import 'package:flutter/material.dart';

import '../../config/variables.dart';
import '../../model/cart_history_item.dart';
import '../../model/payment_method.dart';
import '../../model/user_profile.dart';
import '../../repository/cart_api.dart';
import '../../repository/order_api.dart';
import '../../repository/user_api.dart';
import '../account_auth/components/show_snackbar_msg.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../components/order_list_widget.dart';
import '../home/home_view.dart';
import '../your_purchase/your_purchase_view.dart';
import 'checkout_result_view.dart';
import 'components/payment_info_widget.dart';
import 'components/price_showcase_widget.dart';
import 'components/shipping_address_info_widget.dart';
import 'views/payment_view.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.token});

  final String token;

  @override
  State<StatefulWidget> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  List<OrderItem> _orderList = [];
  double _totalCart = 0,
      _taxPercent = 8,
      _taxPrice = 0,
      _shipPrice = 0,
      _totalPrice = 0;

  UserProfile? _profile;
  ShippingAddressItem _shippingAddress = ShippingAddressItem(
    address:
        "K120/12 Nguyen Luong Bang street, Hoa Khanh Bac, Lien Chieu district",
    city: "Da Nang",
    postalCode: 550000,
    country: "VN",
  );
  String _paymentMethod = PaymentMethod.PayPal;
  String? _numberInfo;

  @override
  void initState() {
    super.initState();
    CartAPI.getCart(token: "").then((value) {
      _orderList = value;
      _totalCart = _orderList.fold(
          0.0, (sum, item) => sum + (item.price * item.quantity));
      _taxPrice = _totalCart * _taxPercent / 100;
      _totalPrice = _totalCart + _taxPrice + _shipPrice;
      setState(() {});
    });
    UserAPI.getProfile(widget.token).then((value) {
      setState(() {
        _profile = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: _mainUI(context),
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          height: 65,
          child: CustomButton(
            label: "Complete payment and place order",
            isFilledColor: true,
            verticalPadding: 0,
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context1) => PaymentView(
                    name: _profile!.name!,
                    paymentMethod: _paymentMethod,
                    shippingAddress: _shippingAddress,
                    subTotal: _totalCart,
                    shippingCost: _shipPrice,
                    orderList: _orderList,
                    onCompleted: (id) async {
                      await _completePayment(
                        context: context,
                        paymentId: id,
                      );
                    },
                    onFailed: (id) async {
                      showSnackbarMessage(
                        context: context,
                        msg:
                            "Failed while completing your payment! Please check your payment and try again.",
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

  Widget _mainUI(BuildContext context) {
    // https://stackoverflow.com/a/59708444
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            OrderListWidget(
              productList: _orderList,
              label: "Your Cart",
            ),
            ShippingAddressInfoWidget(
              name: _profile == null ? "(loading)" : _profile!.name!,
              address: _shippingAddress,
              padding: const EdgeInsets.only(top: 10),
              onClickChange: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.white,
                  builder: (context) => Wrap(
                    children: [
                      _shippingAddressEditor(
                        context: context,
                        shipAddress: _shippingAddress,
                        onChanged: (p0) {
                          setState(() {
                            _shippingAddress = p0;
                          });
                        },
                      )
                    ],
                  ),
                );
              },
            ),
            PaymentInfoWidget(
              method: _paymentMethod,
              numberInfo: _numberInfo,
              padding: const EdgeInsets.only(top: 10),
              onClickChange: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.white,
                  builder: (context) => Wrap(
                    children: [
                      _paymentMethodEditor(
                        context: context,
                        previousPayment: _paymentMethod,
                        onChanged: (p0) {
                          setState(() {
                            _paymentMethod = p0;
                          });
                        },
                      )
                    ],
                  ),
                );
              },
            ),
            PriceShowcaseWidget(
              priceTotalCart: _totalCart,
              priceShip: _shipPrice,
              padding: const EdgeInsets.only(top: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodEditor({
    required BuildContext context,
    required String previousPayment,
    Function(String)? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Choose a payment method",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: List.generate(PaymentMethod.count, (index) {
                  switch (index) {
                    case 0:
                      return _paymentMethodChooser(
                        label: PaymentMethod.PayPal,
                        radioValue: PaymentMethod.PayPal == previousPayment,
                        onClick: () {
                          if (onChanged != null) {
                            onChanged(PaymentMethod.PayPal);
                          }
                          Navigator.pop(context);
                        },
                      );
                    case 1:
                      return _paymentMethodChooser(
                        label: PaymentMethod.MoMo,
                        radioValue: PaymentMethod.MoMo == previousPayment,
                        onClick: () {
                          if (onChanged != null) {
                            onChanged(PaymentMethod.MoMo);
                          }
                          Navigator.pop(context);
                        },
                      );
                    case 2:
                      return _paymentMethodChooser(
                        label: PaymentMethod.CoD,
                        radioValue: PaymentMethod.CoD == previousPayment,
                        onClick: () {
                          if (onChanged != null) {
                            onChanged(PaymentMethod.CoD);
                          }
                          Navigator.pop(context);
                        },
                      );
                    default:
                      return const Center();
                  }
                }),
              ),
            ),
            CustomButton(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              label: "Done",
              fillMaxWidth: true,
              isFilledColor: true,
              onClick: () {
                if (onChanged != null) {
                  onChanged("PayPal");
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _completePayment({
    required BuildContext context,
    required String paymentId,
  }) async {
    showSnackbarMessage(
      context: context,
      msg: "Completing your payment...",
      duration: const Duration(minutes: 5),
    );

    try {
      int id = await OrderAPI.addCart(
        widget.token,
        CartHistoryItem.fromJson({
          "orderItems": List.generate(
              _orderList.length, (index) => _orderList[index].toJson()),
          "shippingAddress": _shippingAddress.toJson(),
          "paymentMethod": _paymentMethod,
          "itemsPrice": _totalCart,
          "shippingPrice": _shipPrice,
          "taxPrice": _taxPrice,
          "totalPrice": _totalPrice,
        }),
      );
      await OrderAPI.markAsPaid(widget.token, id);
      await CartAPI.clearCart();
      ScaffoldMessenger.of(context).clearSnackBars();
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => CheckoutResultView(
            orderId: id.toString(),
            returnHomeClicked: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeView()),
                (Route<dynamic> route) => false,
              );
            },
            deliveryStatusClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyPurchaseView(token: widget.token),
                ),
              );
            },
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (ex) {
      showSnackbarMessage(
        context: context,
        msg:
            "You have completed, but something went wrong! Please send this code to contact support for helping completing your payment: $paymentId",
      );
    }
  }

  Widget _paymentMethodChooser({
    required String label,
    Icon? icon,
    bool radioValue = false,
    Function()? onClick,
  }) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        child: Row(
          children: [
            Radio(
              value: radioValue,
              groupValue: true,
              activeColor: Variables.mainColor,
              onChanged: (value) {
                if (onClick != null) {
                  onClick();
                }
              },
            ),
            icon ?? const Center(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: "Metropolis",
                  fontSize: radioValue ? 20 : 18,
                  fontWeight:
                      radioValue == true ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shippingAddressEditor({
    required BuildContext context,
    required ShippingAddressItem shipAddress,
    Function(ShippingAddressItem)? onChanged,
  }) {
    List<TextEditingController> controller =
        List.generate(4, (index) => TextEditingController());

    controller[0].text = shipAddress.address;
    controller[1].text = shipAddress.city;
    controller[2].text = shipAddress.postalCode.toString();
    controller[3].text = shipAddress.country;

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Edit shipping address",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          CustomTextField(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            labelText: "Address",
            controller: controller[0],
          ),
          CustomTextField(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            labelText: "City",
            controller: controller[1],
          ),
          CustomTextField(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            labelText: "Postal Code",
            controller: controller[2],
          ),
          CustomTextField(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            labelText: "Country Code",
            controller: controller[3],
          ),
          CustomButton(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            label: "Done",
            fillMaxWidth: true,
            isFilledColor: true,
            onClick: () {
              if (onChanged != null) {
                onChanged(ShippingAddressItem(
                  address: controller[0].text,
                  city: controller[1].text,
                  postalCode: int.tryParse(controller[2].text) ?? 0,
                  country: controller[3].text,
                ));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
