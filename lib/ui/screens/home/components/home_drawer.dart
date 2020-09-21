import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ApiGetServices>(context);
    final _mUser = data.mUser;
    String userName = _mUser.firstName + ' ' + _mUser.midName + _mUser.lastName;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: kDefaultColor),
            accountEmail: Text(_mUser.email ?? 'Email'),
            accountName: Text(userName),
            currentAccountPicture: CircleAvatar(
              backgroundImage: _mUser.profileImg == null
                  ? AssetImage('images/avatar.png')
                  : NetworkImage(_mUser.profileImg),
            ),
          ),
          ReuseInkwell.getItem(
            'Home',
            Icons.home,
            () {
              Navigator.pop(context);
            },
          ),
          ReuseInkwell.getItem(
            'Profile',
            Icons.person,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          ReuseInkwell.getItem(
            'Purchase',
            Icons.shopping_basket,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PurchaseScreen()));
            },
          ),
          ReuseInkwell.getItem(
            'Listing',
            Icons.list,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListingScreen()));
            },
          ),
          ReuseInkwell.getItem(
            'Sale',
            Icons.monetization_on,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SalesScreen()));
            },
          ),
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          ReuseInkwell.getItem('Message', Icons.message, () {}),
          ReuseInkwell.getItem('Notification', Icons.notifications, () {}),
          ReuseInkwell.getItem(
            'Settings',
            Icons.settings,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          ),
          ReuseInkwell.getItem(
            'Sign Out',
            Icons.input,
            () {
              signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
