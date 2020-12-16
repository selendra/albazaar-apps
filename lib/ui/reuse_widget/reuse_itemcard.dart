import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class ReuseItemCard extends StatefulWidget {
  @override
  _ReuseItemCardState createState() => _ReuseItemCardState();
}

class _ReuseItemCardState extends State<ReuseItemCard> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).pushNamed('/detail', arguments: product.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(kDefaultRadius * 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultRadius),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 5.0,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Image.network(product.thumbnail, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "${product.price}៛",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
