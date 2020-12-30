import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';

import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ProductListDesktop extends StatefulWidget {
  final List<Product> productsData;
  ProductListDesktop(this.productsData);

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
          itemCount: widget.productsData.length,
          controller: scrollController,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: widget.productsData[index],
            child: ItemCard(),
          ),
        ),
      ),
    );
  }
}
