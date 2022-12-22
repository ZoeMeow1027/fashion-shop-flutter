import 'package:flutter/material.dart';

import '../../../model/product_item.dart';
import '../../../repository/product_api.dart';
import '../components/banner_static_widget.dart';
import 'search_view.dart';
import '../components/product_list_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
    with AutomaticKeepAliveClientMixin<HomeTab> {
  late ScaffoldMessengerState state;

  List<ProductItem>? _productList;
  bool _productListDone = false;
  Future<void> _getProductList() async {
    _productList = await ProductAPI.getProducts();
  }

  Future<void> _refreshData() async {
    _productListDone = false;
    await _getProductList();
    _productListDone = true;
  }

  @override
  void initState() {
    super.initState();
    // This will refresh ui state to force reload
    _refreshData().then((value) {
      try {
        setState(() {});
      } catch (ex) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    state = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: null,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductSearchView(),
                ),
              );
            },
          ),
        ],
      ),
      // https://github.com/flutter/flutter/issues/14842
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        onRefresh: () async {
          await _refreshData().then((value) {
            setState(() {});
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BannerStaticWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _productList != null
                    ? ProductListWidget(
                        productItemList: _productList!,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        showPopularLabel: true,
                      )
                    : _productListDone
                        ? _errorUI()
                        : _loadingUI(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _loadingUI() {
    return const Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorUI() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: const [
          Text(
            "We didn't received any data here. You might need to check your internet connection.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
