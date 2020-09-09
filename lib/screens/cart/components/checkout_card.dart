import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Card(
        elevation: 0,
        shape: kDefaultShape,
        child: Consumer<CartProvider>(
          builder: (context, value, child) => Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: [
                _textRow('Subtotal', '\$${value.totalPrice}'),
                Spacer(),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
                _textRow('Total', '\$${value.totalPrice}'),
                SizedBox(
                  height: 60,
                ),
                ReuseButton.getItem('CHECK OUT', () {}, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textRow(String titleText, String priceText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleText),
        Text(
          priceText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kDefaultColor,
          ),
        ),
      ],
    );
  }
}
