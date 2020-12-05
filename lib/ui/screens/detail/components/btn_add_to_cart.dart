import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class BtnAddToCart extends StatelessWidget {
  final Product loadedProduct;
  BtnAddToCart(this.loadedProduct);
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Container(
        width: 150,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            value.addCart(
              loadedProduct.id.toString(),
              loadedProduct.thumbnail,
              loadedProduct.name,
              loadedProduct.price,
              loadedProduct.orderQty,
            );
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizeService.of(context).translate('add_to_cart'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
