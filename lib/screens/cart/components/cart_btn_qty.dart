import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/models/cart.dart';

class CartBtnQty extends StatelessWidget {
  final Cart product;

  CartBtnQty(this.product);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            addRemoveInkWell(Icons.remove, () {
              value.minusQty(product);
            }),
            SizedBox(
              width: 10,
            ),
            Text(
              product.qty.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            addRemoveInkWell(Icons.add, () {
              //addQty();
              value.addQty(product);
            }),
          ],
        ),
      ),
    );
  }

  Widget addRemoveInkWell(IconData iconData, Function onTap) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultRadius),
            color: Colors.grey[300],
          ),
          child: Icon(
            iconData,
            color: Colors.black,
            size: 20,
          ),
        ));
  }
}
