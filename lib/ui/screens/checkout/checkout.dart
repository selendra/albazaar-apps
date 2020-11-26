import 'package:flutter/material.dart';

import 'package:selendra_marketplace_app/all_export.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String _character = 'Payment Method';
  setVal(String val) {
    setState(() {
      _character = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('check_out'), context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TotalPriceCard(),
              ShippingInformation(),
              PaymentMethod(_character, setVal),
              Consumer<CartProvider>(
                builder: (context, value, child) => Card(
                  elevation: 0,
                  shape: kDefaultShape,
                  child: Container(
                    child: ListTile(
                      title: Text(
                        '${value.items.length} items selected',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.local_grocery_store),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ReuseButton.getItem(
                    _lang.translate('confirm'), () {}, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
