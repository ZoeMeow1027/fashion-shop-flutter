import 'dart:developer';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fashionshop/screens/home/components/popular_product_widget.dart';
import 'package:flutter/material.dart';

import '../../product_details/product_details_view.dart';
import '../../product_search/product_search_view.dart';
import '../components/banner_widget.dart';
import '../components/product_summary_widget.dart';
import '../components/view_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
    with AutomaticKeepAliveClientMixin<HomeTab> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: SingleChildScrollView(
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
            PopularProductListWidget(
              productItemList: widget.viewModel.productItemList,
              padding: const EdgeInsets.only(left: 10, right: 10),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
