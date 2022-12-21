import 'package:flutter/material.dart';

import '../../../model/product_item.dart';
import '../../../repository/product_api.dart';
import '../components/product_list_widget.dart';

class ProductSearchView extends StatefulWidget {
  const ProductSearchView({super.key});

  @override
  State<StatefulWidget> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ProductSearchView> {
  final TextEditingController _controller = TextEditingController();

  List<ProductItem> _total = [], _filter = [];
  String _query = "";

  Future<void> _getProductList() async {
    _total = await ProductAPI.getProducts() ?? [];
  }

  Future<void> _refreshData() async {
    await _getProductList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData().then((value) {
      try {
        _reloadFilter(_query);
        setState(() {});
      } catch (ex) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search a product",
          ),
          onChanged: (value) {
            _reloadFilter(value);
            setState(() {
              _query = value;
            });
          },
        ),
      ),
      body: ProductListWidget(
        productItemList: _filter,
        padding: const EdgeInsets.only(left: 10, right: 10),
      ),
    );
  }

  void _reloadFilter(String query) {
    _filter.clear();
    _filter = _total.where((element) {
      try {
        return element.name!.toLowerCase().contains(query.toLowerCase());
      } catch (ex) {
        return false;
      }
    }).fold([], (previousValue, element) {
      previousValue.add(element);
      return previousValue;
    });
  }
}
