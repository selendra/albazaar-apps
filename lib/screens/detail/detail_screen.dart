import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/detail/components/body.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as int;
    final loadedProduct =
        Provider.of<ProductsProvider>(context).findById(productId);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Consumer<FavoriteProvider>(
              builder: (context, value, child) => InkWell(
                  onTap: () =>
                      value.addFav(loadedProduct), //=> seeFav(context),
                  child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Icon(
                        loadedProduct.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ))),
            ),
            _btnAddToCart(loadedProduct, context),
          ],
        ),
      ),
    );
  }

  Widget _btnAddToCart(Product product, context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Container(
        width: 250,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            //addItemtoCart(context);
            value.addCart(product.id.toString(), product.image, product.title,
                product.price, product.orderQty);

            print('added');
            Navigator.pop(context);
          },
          child: Text(
            "Add To Cart",
            style: TextStyle(color: Colors.white),
          ),
          color: kDefaultColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
        ),
      ),
    );
  }
}
