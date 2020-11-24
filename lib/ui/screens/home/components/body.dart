import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller;
  ProductsProvider productsProvider;
  // void filterSearchResults(String query) {} //Now u
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      productsProvider.fetchListingProduct();
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
                    RaisedButton(
                      child: Text("remove"),
                      onPressed: () async {
                        SharedPreferences _pref = await SharedPreferences.getInstance();
                        _pref.clear();
                      },
                    ),
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
