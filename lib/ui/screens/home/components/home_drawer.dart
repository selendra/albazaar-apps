import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ApiGetServices>(context);
    final _mUser = data.mUser;
    String userName = _mUser.firstName + ' ' + _mUser.midName + _mUser.lastName;
    final _lang = AppLocalizeService.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: kDefaultColor),
            accountEmail: Text(_mUser.email ?? _lang.translate('no_email')),
            accountName: Text(userName ?? 'no username'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: _mUser.profileImg == null
                  ? AssetImage('images/avatar.png')
                  : NetworkImage(_mUser.profileImg),
            ),
          ),
          ReuseInkwell.getItem(
            _lang.translate('home'),
            Icons.home,
            () {
              Navigator.pop(context);
            },
          ),
          ReuseInkwell.getItem(
            _lang.translate('profile'),
            Icons.person,
            () {
              Navigator.pop(context);
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
            _lang.translate('purchase'),
            Icons.shopping_basket,
            () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PurchaseScreen()));
            },
          ),
          ReuseInkwell.getItem(
            _lang.translate('listing'),
            Icons.list,
            () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListingScreen()));
            },
          ),
          ReuseInkwell.getItem(
            _lang.translate('sale'),
            Icons.monetization_on,
            () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SalesScreen()));
            },
          ),
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          ReuseInkwell.getItem(_lang.translate('cart'), Icons.shopping_cart,
              () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          }),
          ReuseInkwell.getItem(_lang.translate('message'), Icons.message, () {
            Navigator.pop(context);
          }),
          ReuseInkwell.getItem(
              _lang.translate('notification'), Icons.notifications, () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ));
          }),
          ReuseInkwell.getItem(
            _lang.translate('setting'),
            Icons.settings,
            () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          ),
          ReuseInkwell.getItem(
            _lang.translate('logout_string'),
            Icons.input,
            () {
              HomeDialog().alertDialog(context);
              //Auth().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
