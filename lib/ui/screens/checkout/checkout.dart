import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _character = 'Shipping Information';
  setVal(String val) {
    setState(() {
      _character = val;
    });
  }

  void validate() {
    if (_character == 'Shipping Information') {
      print('not validate');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Not Validate'),
        duration: Duration(milliseconds: 3000),
      ));
    } else {}
  }

  void submit(String productId, String qty, String address) async {
    await ProductsProvider().addOrder(productId, qty, address);
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
              ShippingInformation(_character, setVal),
              // Consumer<CartProvider>(
              //   builder: (context, value, child) => Card(
              //     elevation: 0,
              //     shape: kDefaultShape,
              //     child: Container(
              //       child: ListTile(
              //         title: Text(
              //           '${value.items.length} items selected',
              //           style: TextStyle(
              //               fontSize: 14.0, fontWeight: FontWeight.bold),
              //         ),
              //         leading: Icon(Icons.local_grocery_store),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ReuseButton.getItem(_lang.translate('confirm'), () {
                  validate();
                }, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
