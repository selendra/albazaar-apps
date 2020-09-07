import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import 'package:selendra_marketplace_app/constants.dart';

class ItemCard extends StatefulWidget {
  /* final Product product;
 
  const ItemCard({
    Key key,
    this.product,
  }) : super(key: key);*/

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: product.id,);
        print(product.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: 180,
                height: 150,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 5.0,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Hero(
                  tag: "${product.id}",
                  child: Image.asset(product.image, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                // products is out demo list
                product.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "\$${product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kDefaultColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
