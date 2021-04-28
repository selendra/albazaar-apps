import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class BtnAddToCart extends StatelessWidget {
  final Product loadedProduct;
  BtnAddToCart(this.loadedProduct);
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Container(
        width: 150,
        height: 50,
        child: ElevatedButton(
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
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(6)),
            backgroundColor: MaterialStateProperty.all(AppServices.hexaCodeToColor(AppColors.primary)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))
              ),
            )
          )
        ),
      ),
    );
  }
}
