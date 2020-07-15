import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/models/products.dart';

import '../../../constants.dart';
import '../../../models/products.dart';

class Body extends StatefulWidget {
  final Product product;
  Body(this.product);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int count = 0;

  void addQty(){
    setState(() {
      count++;
    });
  }
  void minusQty(){
    setState(() {
      if(count>0){
        count--;
      }
      else{
        return ;
      }
    });
  }

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
      body: _body(),
    );
  }

  Widget _body(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Colors.grey[100],
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox (height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _btnQtyRow(),
                  Text(
                    '\$'+widget.product.price.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 23,
                      color: kDefualtColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Text(
                'Product Description',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20.0,),
              Text(dummyText),
            ],
          ),
        ),
      ),
    );
  }
  Widget _btnQty(IconData _iconData,Function onTap){
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: kDefualtColor)
        ),
        child: Icon(_iconData),
      ),
    );
  }

  Widget _btnQtyRow(){
    return Container(
      child: Row(
        children: <Widget>[
          _btnQty(Icons.remove,(){minusQty();}),
          SizedBox(width: 10,),
          Text('$count',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900),),
          SizedBox(width: 10,),
          _btnQty(Icons.add,(){addQty();}),
        ],
      ),
    );
  }



}
