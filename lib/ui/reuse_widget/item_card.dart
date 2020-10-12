import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return GestureDetector(
      onTap: () {
        print(product.id);
        Navigator.of(context).pushNamed(
          '/detail',
          arguments: product.id,
        );
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
                child: Hero(
                  tag: "${product.id}",
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.image),
                    placeholder: AssetImage('images/loading.gif'),
                  ),
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
                "\$${product.price} /" +
                    AppLocalizeService.of(context).translate('kilogram'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDefaultColor,
                    fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
