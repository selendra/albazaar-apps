import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/category/categories.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import '../../../models/products.dart';
import 'item_card.dart';
import 'package:selendra_marketplace_app/screens/detail/detail_screen.dart';
import 'package:selendra_marketplace_app/models/categories.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  ScrollController _controller;

  Future<Null> _getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    return null;
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _controller,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          CategoriesScreen(category),
          SizedBox(
            height: 5,
          ),
          _buildProducts(),
        ],
      ),
    );
  }

  Widget _buildProducts() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          child: GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                  product: products[index],
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  products[index],
                                )));
                  })),
          onRefresh: _getRefresh,
        ),
      ),
    );
  }
}
