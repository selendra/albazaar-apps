import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseItemCard extends StatefulWidget {

  final Product product;
  final Function press;
  const ReuseItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);


  @override
  _ReuseItemCardState createState() => _ReuseItemCardState();
}

class _ReuseItemCardState extends State<ReuseItemCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 5.0,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child:Image.asset(widget.product.image,fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                // products is out demo list
                widget.product.title,
                style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              "\$${widget.product.price}",
              style: TextStyle(fontWeight: FontWeight.bold,color: kDefaultColor),
            )
          ],
        ),
      ),
    );
  }
}

