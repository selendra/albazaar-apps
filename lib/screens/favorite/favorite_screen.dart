import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/favorite/components/body.dart';
import 'package:selendra_marketplace_app/constants.dart';



class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.favorite,color: kDefaultColor,)
      ),
      body: Body(),
    );
  }
}

