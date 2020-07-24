import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/detail/components/body.dart';
import '../../models/products.dart';
import 'package:selendra_marketplace_app/constants.dart';


class DetailScreen extends StatefulWidget {

  final Product products;
  DetailScreen(this.products);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = true;
   final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'));

  IconData _iconFav = Icons.favorite_border;

  void seeFav (){
    setState(() {
      _isFavorite = !_isFavorite;
      if(_isFavorite==true){
        _iconFav = Icons.favorite;
        myFav.add(widget.products);
      }else{
        _iconFav = Icons.favorite_border;
      }
    });
  }



  void addItemtoCart(context){
    if (cart.contains(widget.products)){
       
       Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Item is already in Cart'),
        duration: Duration(seconds: 3)));
    }else{
       cart.add(widget.products);
       Navigator.pop(context);
    }  
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(widget.products),
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
              child: IconButton(icon: Icon(_iconFav,color: Colors.red,),onPressed: (){seeFav();},),
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
      child: Builder(
        builder: (context)
          => RaisedButton(
          onPressed: (){
            addItemtoCart(context); 
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
      ),
    );
  }
}
