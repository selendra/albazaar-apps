import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class TotalPriceCard extends StatelessWidget {
  final String action;
  TotalPriceCard({@required this.action});
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
              margin:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Text(
                AppLocalizeService.of(context).translate('price') + ': ',
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
                  action == 'buy_now'
                      // void filterSearchResults(String query) {} //Now u
                      ? '${value.totalPrice}៛'
                      : '${value.totalAmount}៛',
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
