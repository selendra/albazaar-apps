import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/category/categories.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import '../../../models/products.dart';
import 'item_card.dart';
import 'package:selendra_marketplace_app/screens/detail/detail_screen.dart';
import 'package:selendra_marketplace_app/models/categories.dart';
import 'package:selendra_marketplace_app/screens/category/categories_list.dart';


class Products extends StatefulWidget {

 @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  ScrollController controller;

  Future<Null> _getRefresh () async{
    await Future.delayed(Duration(seconds: 3));
    return null;
  
  }

  @override
  void initState() {
  
    super.initState();
    controller = ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: controller,
      child: Column(
        children: <Widget>[
          CategoriesScreen(category),
          SizedBox(height: 10,),
          Container(
              margin: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Recent Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
          ),
          _buildProducts(),
        ],
      ),
    );
  }
  Widget _buildProducts(){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                        products[index],
                    )));
                  }
              )),
          onRefresh: _getRefresh,
        ),
      ),
    );
  }
}
