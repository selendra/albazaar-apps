import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class TotalPriceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: kDefaultShape,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                'Price: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, value, child) => Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  '${value.totalAmount}៛',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: kDefaultColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
