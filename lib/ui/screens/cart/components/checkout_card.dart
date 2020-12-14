import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class CheckoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Card(
        elevation: 0,
        shape: kDefaultShape,
        child: Consumer<CartProvider>(
          builder: (context, value, child) => Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ReuseButton.getItem(_lang.translate('check_out'), () {
                  Navigator.push(
                      context,
                      RouteAnimation(
                          enterPage: Checkout(
                        action: 'cart',
                      )));
                }, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _textRow(String titleText, String priceText) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(titleText),
  //       Text(
  //         priceText,
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           color: kDefaultColor,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
