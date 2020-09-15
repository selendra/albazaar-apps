import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class BtnAddToCart extends StatelessWidget {
  final Product loadedProduct;
  BtnAddToCart(this.loadedProduct);
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Container(
        width: 250,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            value.addCart(
              loadedProduct.id.toString(),
              loadedProduct.image,
              loadedProduct.title,
              loadedProduct.price,
              loadedProduct.orderQty,
            );
            Navigator.pop(context);
          },
          child: Text(
            "Add to Cart",
            style: TextStyle(color: Colors.white),
          ),
          color: kDefaultColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
        ),
      ),
    );
  }
}
