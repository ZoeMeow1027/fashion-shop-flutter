import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  static const data = [
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
  ];

// https://stackoverflow.com/questions/63148054/how-to-fix-horizontal-viewport-was-given-unbounded-height
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Item details"), // TODO
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Image.network(data[index], width: 300, height: 300);
              },
            ),
          ),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddToCartOptions(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    50), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text("Add to cart"),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddToCartOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Modal BottomSheet'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buttonColor(
                  backColor: Colors.red,
                  checked: false,
                  onClick: () {},
                ),
                buttonColor(
                  backColor: Colors.blue,
                  checked: false,
                  onClick: () {},
                ),
                buttonColor(
                  backColor: Colors.black,
                  checked: false,
                  onClick: () {},
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget buttonColor(
      {required Color backColor,
      required bool checked,
      required void Function()? onClick}) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: backColor),
          ),
        ),
      ),
      child: Text(checked ? "OK" : ""),
    );
  }
}
