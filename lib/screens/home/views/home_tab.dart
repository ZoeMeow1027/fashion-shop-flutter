import 'package:flutter/material.dart';

import '../../product_search/product_search_view.dart';
import '../components/search_bar_click.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SearchBarClick(
              placeholderText: "Search a product",
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductSearchView()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
