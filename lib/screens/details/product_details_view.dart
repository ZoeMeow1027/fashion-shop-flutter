import 'package:fashionshop/screens/details/components/app_bar.dart';
import 'package:fashionshop/screens/details/components/current_state.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<StatefulWidget> createState() => _ProductDetailsView();
}

class _ProductDetailsView extends State<ProductDetailsView> {
  final List<int> availableColors = [
    Colors.blue.value,
    Colors.red.value,
    Colors.black.value,
    Colors.pink.value,
    Colors.purple.value,
    Colors.green.value,
    Colors.lightBlue.value,
    Colors.lightGreen.value,
    Colors.yellow.value,
    Colors.amber.value,
  ];

  final List<String> previewList = [
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
  ];

  late CurrentState currentState;

  @override
  void initState() {
    super.initState();
    currentState = CurrentState();
    currentState.selectedColor = availableColors[0];
    currentState.selectedCount = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        onBackClicked: () {
          Navigator.pop(context);
        },
        onCartClicked: () {},
        onSearchClicked: () {},
      ),
      body: Body(
        currentState: currentState,
        availableColors: availableColors,
        previewList: previewList,
        onStateChanged: (state) {
          setState(() {
            currentState = state;
          });
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Send request to add to cart
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Add to cart"),
            ),
          ),
        ),
      ),
    );
  }
}
