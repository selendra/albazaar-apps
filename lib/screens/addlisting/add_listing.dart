import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/addlisting/components/body.dart';
import 'package:selendra_marketplace_app/constants.dart';

class AddListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Listing',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: kDefualtColor,),onPressed: (){Navigator.pop(context);},),
      ),
      body: Body(),
    );
  }
}
