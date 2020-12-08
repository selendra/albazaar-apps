import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller;
  ProductsProvider productsProvider;
  SellerProvider sellerProvider;
  // void filterSearchResults(String query) {} //Now u
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      productsProvider = Provider.of<ProductsProvider>(context, listen: false);
      productsProvider.fetchListingProduct();
      sellerProvider.fetchBuyerOrder();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productsProvider = Provider.of<ProductsProvider>(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: productsProvider.items.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: _controller,
              child: Container(
                child: Column(
                  children: <Widget>[
                    //SearchBar(),
                    SizedBox(
                      height: 10,
                    ),
                    CategoriesScreen(category),
                    ProductList(productsProvider.items),
                  ],
                ),
              ),
            ),
    );
  }
}
