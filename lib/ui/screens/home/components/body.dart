import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller;

  // void filterSearchResults(String query) {} //Now u

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
    final productsData = Provider.of<ProductsProvider>(context);
    return SingleChildScrollView(
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
            ProductList(productsData.items),
          ],
        ),
      ),
    );
  }
}
