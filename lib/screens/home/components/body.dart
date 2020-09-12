import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller;
  String dropDownValue = 'EN', _query;
  final _searchKey = GlobalKey<FormFieldState<String>>();

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
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20),
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
                    DropDownButtons(),
                  ],
                )),
            CategoriesScreen(category),
            ProductList(),
          ],
        ),
      ),
    );
  }
}
