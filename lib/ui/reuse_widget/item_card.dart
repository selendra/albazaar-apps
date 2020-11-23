import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return GestureDetector(
      onTap: () {
        Provider.of<ProductsProvider>(context, listen: false)
            .findImgById(product.id);

        Navigator.of(context).pushNamed(
          '/detail',
          arguments: product.id,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kDefaultRadius * 2),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black54.withOpacity(0.2),
          //     blurRadius: 10.0,
          //     spreadRadius: 1.0,
          //     offset: Offset(1.0, 1.0),
          //   )
          // ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultRadius * 2),
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
                    image: NetworkImage(product.thumbnail),
                    placeholder: AssetImage('images/loading.gif'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                // products is out demo list
                product.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "${product.price}៛ /" +
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
