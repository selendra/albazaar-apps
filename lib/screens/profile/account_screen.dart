import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse.inkwell.dart';
import 'package:selendra_marketplace_app/services/auth/auth_services.dart';
import 'package:selendra_marketplace_app/screens/purchase/purchase_screen.dart';
import 'package:selendra_marketplace_app/screens/listing/listing_screen.dart';
import 'package:selendra_marketplace_app/screens/sales/sale_screen.dart';
import 'package:selendra_marketplace_app/screens/setting/setting_screen.dart';
import 'package:selendra_marketplace_app/screens/profile/profile_screen.dart';
import 'package:selendra_marketplace_app/models/user.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String myEmail = mUser.email;
  String myName = mUser.firstName;
  String myImageUrl = mUser.profileImg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello,',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        myName ?? 'Username',
                        style: TextStyle(
                            color: kDefualtColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: myImageUrl != null
                              ? NetworkImage('$myImageUrl')
                              : AssetImage('images/avatar.png'),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ReuseInkwell.getItem('Profile', Icons.account_circle, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(myName, myImageUrl, myEmail)));
            }), //Add a List
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.grey[300],
            ),
            ReuseInkwell.getItem('Purchase', Icons.shopping_basket, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PurchaseScreen()));
            }),
            ReuseInkwell.getItem('Listing', Icons.list, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListingScreen()));
            }),
            ReuseInkwell.getItem('Sale', Icons.monetization_on, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SalesScreen()));
            }),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.grey[300],
            ),
            ReuseInkwell.getItem('Message', Icons.message, () {}),
            ReuseInkwell.getItem('Notification', Icons.notifications, () {}),
            ReuseInkwell.getItem('Settings', Icons.settings, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            }),
            ReuseInkwell.getItem('Sign Out', Icons.input, () {
              signOut(context);
            }),
          ],
        ),
      ),
    );
  }
}
