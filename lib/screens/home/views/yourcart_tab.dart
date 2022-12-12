import 'package:flutter/material.dart';

import '../../product_search/product_search_view.dart';

class YourCartTab extends StatelessWidget {
  const YourCartTab({super.key});

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
    );
  }
}
