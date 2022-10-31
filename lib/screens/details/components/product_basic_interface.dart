import 'package:flutter/cupertino.dart';

class ProductBasicInterface extends StatelessWidget {
  const ProductBasicInterface({super.key, required this.previewList});

  final List<String> previewList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImagePreview(previewList: previewList),
        const Text("Product 1"),
        const Text("\$25.00"),
      ],
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({super.key, required this.previewList});

  final List<String> previewList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: previewList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
            child: Image.network(previewList[index], width: 200, height: 200),
          );
        },
      ),
    );
  }
}
