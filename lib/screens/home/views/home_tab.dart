import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../model/product_item.dart';
import '../../../repository/product_api.dart';
import '../../product_search/product_search_view.dart';
import '../components/banner_widget.dart';
import '../components/popular_product_widget.dart';

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
    setState(() {
      _productListDone = false;
    });
    await _getProductList();
    setState(() {
      _productListDone = true;
    });
  }

  @override
  void initState() {
    super.initState();
    // This will refresh ui state to force reload
    _refreshData().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    state = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
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
              // TODO: Need banner image api here!
              const BannerWidget(
                imageList: [
                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                  "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                  "https://cdn.pixabay.com/photo/2017/01/19/23/46/church-1993645__340.jpg",
                  "https://jes.edu.vn/wp-content/uploads/2017/10/h%C3%ACnh-%E1%BA%A3nh.jpg",
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _productList != null
                    ? _mainUI(data: _productList!)
                    : _productListDone
                        ? _errorUI()
                        : _loadingUI(),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: FutureBuilder(
              //     future: refreshData(),
              //     builder: (context, snapshot) {
              //       if (_productList != null) {
              //         return _mainUI(data: _productList!);
              //       } else if (snapshot.connectionState ==
              //           ConnectionState.done) {
              //         return _errorUI();
              //       } else {
              //         return _loadingUI();
              //       }
              //     },
              //   ),
              // ),
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

  Widget _mainUI({
    required List<ProductItem> data,
  }) {
    return PopularProductListWidget(
      productItemList: data,
      padding: const EdgeInsets.only(left: 10, right: 10),
    );
  }
}
