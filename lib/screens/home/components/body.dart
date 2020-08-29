import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/category/categories.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import '../../../models/products.dart';
import 'item_card.dart';
import 'package:selendra_marketplace_app/screens/detail/detail_screen.dart';
import 'package:selendra_marketplace_app/models/categories.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_search_field.dart';
import 'package:selendra_marketplace_app/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller;
  String dropDownValue = 'EN', _query;
  final _searchKey = GlobalKey<FormFieldState<String>>();
  List<Product> mProducts = products;

  void filterSearchResults(String query) {
   
  } //Now u

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
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ReuseSearchField(
                    fieldKey: _searchKey,
                    labelText: 'Search',
                    iconData: Icons.language,
                    onFieldSubmitted: (value) {
                      _query = value;
                      print(_query);
                    },
                  ),
                  Container(
                      child: DropdownButton<String>(
                    value: dropDownValue,
                    underline: Container(
                      color: Colors.white,
                    ),
                    style: TextStyle(color: kDefualtColor),
                    icon: Icon(
                      Icons.language,
                      color: kDefualtColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                      });
                    },
                    items: <String>['EN', 'KH']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
                ],
              )),
          CategoriesScreen(category),
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
        child: GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
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
      ),
    );
  }
}
