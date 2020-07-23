import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/products.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: myFav.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(myFav[index].title),
          );
        }
      ),
    );
  }
}
