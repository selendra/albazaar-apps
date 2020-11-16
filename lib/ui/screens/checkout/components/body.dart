import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/ui/screens/checkout/components/order_confirmation.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _character;

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10, top: 10.0),
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
                ],
              ),
            ),
            Card(
              elevation: 0,
              shape: kDefaultShape,
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Information',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: kDefaultColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      RouteAnimation(
                                          enterPage: OrderConfirmation()));
                                })
                          ],
                        ),
                        value.mUser.address == null
                            ? Container()
                            : Column(
                                children: [
                                  ReuseInkwell.getItem(value.mUser.firstName,
                                      Icons.account_circle, () {}),
                                  ReuseInkwell.getItem(
                                      value.mUser.address ?? 'null',
                                      Icons.location_on,
                                      () {}),
                                  ReuseInkwell.getItem(
                                      value.mUser.phonenumber ?? 'phone',
                                      Icons.phone,
                                      () {}),
                                  ReuseInkwell.getItem(
                                      value.mUser.email ?? 'email',
                                      Icons.mail,
                                      () {}),
                                ],
                              )
                      ],
                    );
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: kDefaultColor,
                                ),
                              ),
                              title: Text('Select Payment Method'),
                            ),
                            RadioListTile(
                              activeColor: kDefaultColor,
                              title: Text('Direct Payment'),
                              value: 'Direct Payment',
                              groupValue: _character,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                            RadioListTile(
                              activeColor: kDefaultColor,
                              title: Text('Escrow Payment'),
                              value: 'Escrow Payment',
                              groupValue: _character,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _character = value;
                                });
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              child: Card(
                elevation: 0,
                shape: kDefaultShape,
                child: Container(
                  child: ListTile(
                    title: Text(
                      'Select Payment Method',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.payment),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Card(
                elevation: 0,
                shape: kDefaultShape,
                child: Container(
                  child: ListTile(
                    title: Text(
                      '6 items selected',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.local_grocery_store),
                    trailing: Icon(Icons.arrow_forward_ios),
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
    );
  }
}
