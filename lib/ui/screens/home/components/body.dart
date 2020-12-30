import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:webscrollbar/webscrollbar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller;
  ScrollController _webController;
  ProductsProvider productsProvider;

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) async {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchListingProduct();
      Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
      await Provider.of<TrxHistoryProvider>(context, listen: false)
          .fetchTrxHistory();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _webController = ScrollController();
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
          : WebScrollBar(
              controller: _webController,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: _controller,
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        children: <Widget>[
                          //SearchBar(),

                          RaisedButton(onPressed: () {
                            Provider.of<DarkMode>(context, listen: false)
                                .setDarkMode(true);
                          }),
                          const SizedBox(height: 10),
                          CategoriesScreen(category),
                          ProductList(productsProvider.items),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              visibleHeight: MediaQuery.of(context).size.height,
            ),
    );
  }
}
