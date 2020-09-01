import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  final Product product;
  Body(this.product);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int count = 0;

  void addQty() {
    setState(() {
      count++;
    });
  }

  void minusQty() {
    setState(() {
      if (count > 0) {
        count--;
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: kDefaultColor,
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
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

  Widget _body() {
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
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //_btnQtyRow(),
                  BtnQty('$count', addQty, minusQty),
                  Text(
                    '\$' + widget.product.price.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 23,
                      color: kDefaultColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(widget.product.description),
            ],
          ),
        ),
      ),
    );
  }

  
}
