import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              shape: kDefaultShape,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        'Total Price',
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
                          '\$ ${value.totalAmount}',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kDefaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 0,
              shape: kDefaultShape,
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Form(
                  child: Column(
                    children: [
                      ReuseTextField(
                        labelText: _lang.translate('name'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ReuseTextField(
                        labelText: _lang.translate('phone'),
                      ),
                      SizedBox(height: 10),
                      ReuseTextField(
                        labelText: _lang.translate('email'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ReuseTextField(
                        labelText: _lang.translate('postcode'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ReuseTextField(
                        labelText: _lang.translate('shipping_address'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: ReuseTextField(
                  labelText: _lang.translate('order_note'),
                  maxLine: 2,
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
