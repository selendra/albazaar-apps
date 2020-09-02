import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/models/products.dart';

class CartBtnQty extends StatelessWidget {
  final Product product;
  final Function addQty;
  final Function removeQty;
  final int qty;

  CartBtnQty(this.addQty, this.removeQty, this.qty, this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          addRemoveInkWell(Icons.remove, () {
            removeQty();
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
            addQty();
          }),
        ],
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
