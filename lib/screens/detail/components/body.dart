import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/models/products.dart';

import '../../../constants.dart';
import '../../../models/products.dart';
import '../../../models/products.dart';

class Body extends StatefulWidget {
  final Product product;
  Body(this.product);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
  Widget _buildBody(){
    return NestedScrollView(
        headerSliverBuilder: (context,innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: kDefualtColor,
              ),
              expandedHeight: MediaQuery.of(context).size.height/2,
              floating: true,
              pinned: true,
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: "${widget.product.id}",
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ];
      },
        body: Container(
          margin: EdgeInsets.only(top: 10.0,left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox (height: 10.0,),
              Text(
                '\$'+widget.product.price.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: kDefualtColor,
                ),
              ),
              SizedBox(height: 15.0,),
              Text(dummyText),
            ],
          ),
        )
    );
  }
}
