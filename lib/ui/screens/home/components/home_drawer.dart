import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/core/services/app_services.dart';

class HomeDrawer extends StatelessWidget {

  PrefService _pref = PrefService();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserProvider>(context);
    final _mUser = data.mUser;
    String userName = _mUser.firstName == null &&
            _mUser.midName == null &&
            _mUser.lastName == null
        ? "User name"
        : _mUser.firstName + ' ' + _mUser.midName + _mUser.lastName;
    final _lang = AppLocalizeService.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: kDefaultColor),
            accountEmail: Text(
              _mUser.email ?? _lang.translate('no_email'),
              style: TextStyle(color: Colors.white),
            ),
            accountName: Text(
              userName ?? 'no username', // userName ?? 'no username',
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundImage: _mUser.profileImg == '' || _mUser.profileImg == null
                    ? AssetImage('images/avatar.png')
                    : NetworkImage(_mUser.profileImg)),
          ),
          ReuseInkwell.getItem(
            _lang.translate('market'),
            () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('images/market.svg', width: 25, height: 25),
          ),
          ReuseInkwell.getItem(
            _lang.translate('profile'),
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfileView);
            },
            icon: Icon(Icons.person),
          ),
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          ReuseInkwell.getItem(
            _lang.translate('cart'), 
              () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CartView);
            },
            icon: Icon(Icons.shopping_cart),
          ),
          ReuseInkwell.getItem(
            _lang.translate('listing'),
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ListingView);
            },
            icon: SvgPicture.asset('images/shop.svg', width: 25, height: 25),
          ),
          ReuseInkwell.getItem(
            _lang.translate('order'),
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PurchaseView);
              // Navigator.push(context,
            },
            icon: Icon(Icons.shopping_basket),
          ),

          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          // ReuseInkwell.getItem(
          //   _lang.translate('purchase'),
          //   icon: Icon(Icons.shopping_basket),
          //   () {
          //     Navigator.pop(context);
          //     Navigator.pushNamed(context, PurchaseView);
          //     // Navigator.push(context,
          //   },
          // ),
          ReuseInkwell.getItem(_lang.translate('message'), 
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ChatView);
            },
            icon: Icon(Icons.message), 
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, NotificationView);
            },
            splashColor: Colors.grey,
            child: ListTile(
              title: Text(
                _lang.translate('notification'),
              ),
              leading: Icon(Icons.notifications),
              dense: true,
              trailing: Icon(
                Icons.brightness_1,
                size: 20.0,
                color: Colors.red,
              ),
            ),
          ),
          ReuseInkwell.getItem(
            _lang.translate('setting'),
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SettingView);
            },
            icon: Icon(Icons.settings),
          ),
          ReuseInkwell.getItem(
            _lang.translate('logout_string'),
            () async {
              var isShow = await _pref.read('isshow');
              
              // Clear All Local Data
              await AppServices.clearStorage();

              // Save Carousel Screen
              await _pref.saveString('isshow', isShow);
              HomeDialog().alertDialog(context);
              // Auth().signOut(context);
            },
            icon: Icon(Icons.input),
          ),
        ],
      ),
    );
  }
}
