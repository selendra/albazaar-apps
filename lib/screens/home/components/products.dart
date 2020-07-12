import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import 'item_card.dart';
import 'package:selendra_marketplace_app/screens/detail/detail_screen.dart';

class Products extends StatefulWidget {


 @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {


  Future<Null> _getRefresh () async{
    await Future.delayed(Duration(seconds: 3));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProducts();
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen()));
                  }
              )),
          onRefresh: _getRefresh,
        ),
      ),
    );
  }
}
