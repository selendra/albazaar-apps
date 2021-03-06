import 'package:flutter/material.dart';
import 'item_card.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/all_export.dart';

class ProductList extends StatefulWidget {
  final List<Product> productsData;
  ProductList(this.productsData);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //fetch more
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: 10,//widget.productsData.length,
          controller: scrollController,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ItemCard()
          // ChangeNotifierProvider.value(
          //   value: widget.productsData[index],
          //   child: ItemCard(),
          // ),
        ),
      ),
    );
  }
}
