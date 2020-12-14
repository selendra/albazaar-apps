import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Checkout extends StatefulWidget {
  final String action;
  Checkout({this.action});
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
      try {
        if (widget.action == 'buy_now') {
          final buyNow =
              Provider.of<CartProvider>(context, listen: false).isBuyNow;
          if (buyNow != null) {
            Provider.of<ProductsProvider>(context, listen: false).addOrder(
              buyNow.id,
              buyNow.qty.toString(),
              _address,
            );
          }
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
        }
        Provider.of<ProductsProvider>(context, listen: false)
            .fetchListingProduct();
      } catch (e) {} finally {
        Navigator.pop(context);
        await ReuseAlertDialog().customDialog(
            context, 'Your order has been placed successfully!', () {
          Provider.of<CartProvider>(navigationKey.currentState.overlay.context,
                  listen: false)
              .clear();
          Navigator.pop(navigationKey.currentState.overlay.context);
        });
      }
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
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TotalPriceCard(
                action: widget.action,
              ),
              //ShippingInformation(),
              SizedBox(
                height: 20,
              ),
              ProductDisplay(
                action: widget.action,
              ),
              ShippingInformation(_address, setVal),
              SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.all(10.0),
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
