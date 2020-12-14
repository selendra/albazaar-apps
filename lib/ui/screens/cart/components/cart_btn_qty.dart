import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class CartBtnQty extends StatelessWidget {
  final String id;
  final int qty;

  CartBtnQty(this.id, this.qty);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            addRemoveInkWell(Icons.remove, () {
              value.minusQty(id);
            }),
            SizedBox(
              width: 10,
            ),
            Text(
              qty.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            addRemoveInkWell(Icons.add, () {
              //addQty();
              value.addQty(id);
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
            color: kDefaultColor,
            size: 20,
          ),
        ));
  }
}
