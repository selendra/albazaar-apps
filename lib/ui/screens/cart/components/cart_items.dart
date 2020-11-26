import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class CartItems extends StatelessWidget {
  final String image;
  final String productName;
  final String price;
  final String productId;
  final int qty;

  CartItems(this.image, this.productName, this.price, this.qty, this.productId);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Product Removed"),
          duration: Duration(milliseconds: 300),
        ));
      },
      background: DimissibleBackground(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kDefaultRadius),
        ),
        child: ListTile(
          shape: kDefaultShape,
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(image),
          ),
          title: Text(
            productName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            price.toString() + '៛',
            style: TextStyle(color: kDefaultColor, fontWeight: FontWeight.bold),
          ),
          trailing: CartBtnQty(productId, qty),
        ),
      ),
    );
  }
}
