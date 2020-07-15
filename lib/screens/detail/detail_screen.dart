import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/detail/components/body.dart';
import '../../models/products.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/cart/cart.dart';

class DetailScreen extends StatelessWidget {

  final Product products;
  DetailScreen(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(products),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }
  Widget _buildBottomNavigation(context){
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Icon(Icons.favorite_border,color: Colors.red,),
            )
          ),
          _btnAddToCart(context)
        ],
      ),
    );
  }
  Widget _btnAddToCart(context){
    return Container(
      width: 250,
      height: 50,
      child: RaisedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
        },
        child: Text(
          "Add To Cart",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        color: kDefualtColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
      ),
    );
  }

}
