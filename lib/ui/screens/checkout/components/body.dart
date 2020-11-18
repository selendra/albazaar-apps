import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _character = 'Payment Method';
  setVal(String val) {
    setState(() {
      _character = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TotalPriceCard(),
            ShippingInformation(),
            PaymentMethod(_character, setVal),
            Card(
              elevation: 0,
              shape: kDefaultShape,
              child: Container(
                child: ListTile(
                  title: Text(
                    '6 items selected',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.local_grocery_store),
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
    );
  }
}
