import 'package:flutter/material.dart';

class ProductSearchView extends StatefulWidget {
  const ProductSearchView({super.key});

  @override
  State<StatefulWidget> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ProductSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: "Search a product",
          ),
        ),
      ),
    );
  }
}
