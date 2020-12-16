import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

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
                backgroundImage: _mUser.profileImg == null
                    ? AssetImage('images/avatar.png')
                    : NetworkImage(_mUser.profileImg)),
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
              Navigator.pushNamed(context, ProfileView);
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
            Navigator.pushNamed(context, CartView);
          }),
          ReuseInkwell.getItem(
            _lang.translate('listing'),
            Icons.list,
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ListingView);
            },
          ),
          ReuseInkwell.getItem(
            _lang.translate('order'),
            Icons.shopping_basket,
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PurchaseView);
              // Navigator.push(context,
            },
          ),

          Container(
            height: 2,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          // ReuseInkwell.getItem(
          //   _lang.translate('purchase'),
          //   Icons.shopping_basket,
          //   () {
          //     Navigator.pop(context);
          //     Navigator.pushNamed(context, PurchaseView);
          //     // Navigator.push(context,
          //   },
          // ),
          ReuseInkwell.getItem(_lang.translate('message'), Icons.message, () {
            Navigator.pop(context);
            Navigator.pushNamed(context, ChatView);
          }),
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
            Icons.settings,
            () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SettingView);
            },
          ),
          ReuseInkwell.getItem(
            _lang.translate('logout_string'),
            Icons.input,
            () async {
              var isShow = await _pref.read('isshow');

              // Clear All Local Data
              await AppServices.clearStorage();

              // Save Carousel Screen
              await _pref.saveString('isshow', isShow);
              HomeDialog().alertDialog(context);
              // Auth().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
