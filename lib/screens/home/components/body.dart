import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/category/categories.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import '../../../models/products.dart';
import 'package:selendra_marketplace_app/models/categories.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_search_field.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'product_list.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller;
  String dropDownValue = 'EN', _query;
  final _searchKey = GlobalKey<FormFieldState<String>>();
  List<Product> mProducts = products;

  void filterSearchResults(String query) {} //Now u

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
          ProductList(),
        ],
      ),
    );
  }

  
}
