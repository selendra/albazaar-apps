import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detail',
          arguments: product.id,
        );

        Provider.of<ProductsProvider>(context, listen: false)
            .findImgById(product.id);
      },
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(kDefaultRadius),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.3,
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "${product.price}៛ /" +
                          AppLocalizeService.of(context).translate('kilogram'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kDefaultColor,
                        fontSize: 14.0,
                      ).copyWith(wordSpacing: 0),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Align(
                alignment: Alignment.topRight,
                child: Consumer<FavoriteProvider>(
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () {
                        value.isFav(product);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.6),
                        ),
                        child: Icon(
                          product.isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
