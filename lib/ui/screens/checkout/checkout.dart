import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _address = 'Shipping Information';
  setVal(String val) {
    setState(() {
      _address = val;
    });
  }

  void validate(context) async {
    if (_address == 'Shipping Information') {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('You need to fill in your address.'),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      final cartProduct =
          Provider.of<CartProvider>(context, listen: false).items;
      for (int i = 0; i < cartProduct.length; i++) {
        Provider.of<ProductsProvider>(context, listen: false).addOrder(
          cartProduct.values.toList()[i].id,
          cartProduct.values.toList()[i].qty.toString(),
          _address,
        );
      }
      Navigator.pop(context);

      ReuseAlertDialog().customDialog(
        context,
        'Make order succesfully',
        () {
          Provider.of<CartProvider>(navigationKey.currentState.overlay.context,
                  listen: false)
              .clear();
          Navigator.pop(navigationKey.currentState.overlay.context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _lang = AppLocalizeService.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('check_out'), context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TotalPriceCard(),
              //ShippingInformation(),
              SizedBox(
                height: 20,
              ),
              ProductDisplay(),
              ShippingInformation(_address, setVal),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ReuseButton.getItem(_lang.translate('confirm'), () {
                  validate(context);
                }, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
