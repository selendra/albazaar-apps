import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/core/services/app_services.dart';

class HomeDrawer extends StatelessWidget {

  final PrefService _pref = PrefService();

  final iconText = [
    {'icon': 'assets/icons/cart.svg', 'title': 'card', 'route': CartScreen()},
    {'icon': 'assets/icons/shop.svg', 'title': 'shop', 'route': ShopScreen()},
    {'icon': 'assets/icons/order.svg', 'title': 'order', 'route': PurchaseScreen()},
    {'icon': 'assets/icons/chat.svg', 'title': 'chat', 'route': MessageScreen()},


    {'icon': 'assets/icons/referral.svg', 'title': 'invitation', 'route': MessageScreen()},
    {'icon': 'assets/icons/belt.svg', 'title': 'notificatioin', 'route': NotificationScreen()},
    {'icon': 'assets/icons/favorite.svg', 'title': 'favorite', 'route': FavoriteScreen()},
    {'icon': 'assets/icons/setting.svg', 'title': 'settings', 'route': FavoriteScreen()},
    {'icon': 'assets/icons/sign_out.svg', 'title': 'sign_out',},
  ];

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserProvider>(context);
    // final _mUser = data.mUser;
    // String userName = _mUser.firstName == null &&
    //         _mUser.midName == null &&
    //         _mUser.lastName == null
    //     ? "User name"
    //     : _mUser.firstName + ' ' + _mUser.midName + _mUser.lastName;
    final _lang = AppLocalizeService.of(context);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            //Profile
            MyCard(
              bBottomLeft: 0, bBottomRight: 0,
              bTopLeft: 0, bTopRight: 0,
              pLeft: 25, pTop: 25, pBottom: 25, pRight: 25,
              mBottom: 20,
              hexaColor: AppColors.white,
              // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
              width: double.infinity,
              align: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  MyCard(
                    hexaColor: AppColors.secondary,
                    mRight: 10,
                    width: 70, height: 70,
                    align: Alignment.centerLeft,
                    child: SvgPicture.asset('assets/avatar_user.svg', width: 40, height: 40),
                  ),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MyText(
                          textAlign: TextAlign.left,
                          color: AppColors.primary,
                          pRight: 10,
                          text: 'Daveat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),

                        MyText(
                          textAlign: TextAlign.left,
                          text: 'Phnom penh (Steng mean chey)',
                          fontSize: 12,
                        )
                      ],
                    )
                  ),

                  Container(
                    margin: EdgeInsets.only(left:  10),
                    child: Icon(Icons.arrow_forward_ios, size: 12),
                  )
                ],
              )
            ),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  // UserAccountsDrawerHeader(
                  //   decoration: BoxDecoration(color: Colors.white),
                  //   accountEmail: MyText(text: 'no_email',
                  //     // _mUser.email ?? _lang.translate('no_email'),
                  //     color: AppColors.primary
                  //   ),
                  //   accountName: MyText(text: 'no username',
                  //     // userName ?? 'no username', // userName ?? 'no username',
                  //     color: AppColors.black
                  //   ),
                  //   // currentAccountPicture: CircleAvatar(
                  //       // backgroundImage: _mUser.profileImg == '' || _mUser.profileImg == null
                  //       //     ? AssetImage('assets/avatar.png')
                  //       //     : NetworkImage(_mUser.profileImg)),
                  // ),

                  //Store
                  MyText(
                    pTop: 8,
                    pBottom: 8,
                    textAlign: TextAlign.left,
                    text: "Marketplace",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    bottom: 8,
                    left: 25,
                  ),

                  for (int i = 0; i <= 3; i ++)
                  MyFlatButton(
                    buttonColor: AppColors.white,
                    borderRadius: 0,
                    child: MyPadding(
                      pLeft: 25, pTop: 15, pBottom: 15, pRight: 15,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 50,
                            child: SvgPicture.asset(iconText[i]['icon'], width: 30, height: 30),
                          ),

                          MyText(text: iconText[i]['title'], textAlign: TextAlign.left), //_lang.translate(iconText[i]['title']),

                          Expanded(child: Container()),

                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppServices.hexaCodeToColor(AppColors.black),
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    action: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => iconText[i]['route']));
                    }
                  ),

                  //Generl
                  MyText(
                    pTop: 8,
                    pBottom: 8,
                    textAlign: TextAlign.left,
                    text: "General",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    bottom: 8,
                    left: 25,
                  ),

                  for (int i = 4; i < iconText.length; i ++)
                  MyFlatButton(
                    buttonColor: AppColors.white,
                    borderRadius: 0,
                    child: MyPadding(
                      pLeft: 25, pTop: 15, pBottom: 15, pRight: 15,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 50,
                            child: SvgPicture.asset(iconText[i]['icon'], width: 30, height: 30),
                          ),

                          MyText(text: iconText[i]['title'], textAlign: TextAlign.left), //_lang.translate(iconText[i]['title']),

                          Expanded(child: Container()),

                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppServices.hexaCodeToColor(AppColors.black),
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    action: ()async {

                      if (i == iconText.length -1){
                        var isShow = await _pref.read('isshow');
                        
                        // Clear All Local Data
                        await AppServices.clearStorage();

                        // Save Carousel Screen
                        await _pref.saveString('isshow', isShow);
                        HomeDialog().alertDialog(context);
                        // Auth().signOut(context);
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => iconText[i]['route']));
                      }
                    }
                  ),
                  
                  // ReuseInkwell.getItem(
                  //   _lang.translate('profile'),
                  //   () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, ProfileView);
                  //   },
                  //   icon: Icon(Icons.person),
                  // ),

                  // Container(
                  //   height: 2,
                  //   margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  //   color: Colors.grey[300],
                  // ),
                  // ReuseInkwell.getItem(
                  //   _lang.translate('cart'), 
                  //     () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, CartView);
                  //   },
                  //   icon: Icon(Icons.shopping_cart),
                  // ),

                  // ReuseInkwell.getItem(
                  //   _lang.translate('listing'),
                  //   () {
                  //     Navigator.pop(context);
                  //     // Navigator.pushNamed(context, ListingView);
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => ListingScreen()));
                  //   },
                  //   icon: SvgPicture.asset('assets/shop.svg', width: 25, height: 25),
                  // ),
                  // ReuseInkwell.getItem(
                  //   _lang.translate('order'),
                  //   () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, PurchaseView);
                  //     // Navigator.push(context,
                  //   },
                  //   icon: Icon(Icons.shopping_basket),
                  // ),

                  // Container(
                  //   height: 2,
                  //   margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  //   color: Colors.grey[300],
                  // ),
                  // // ReuseInkwell.getItem(
                  // //   _lang.translate('purchase'),
                  // //   icon: Icon(Icons.shopping_basket),
                  // //   () {
                  // //     Navigator.pop(context);
                  // //     Navigator.pushNamed(context, PurchaseView);
                  // //     // Navigator.push(context,
                  // //   },
                  // // ),
                  // ReuseInkwell.getItem(_lang.translate('message'), 
                  //   () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, ChatView);
                  //   },
                  //   icon: Icon(Icons.message), 
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, NotificationView);
                  //   },
                  //   splashColor: Colors.grey,
                  //   child: ListTile(
                  //     title: Text(
                  //       _lang.translate('notification'),
                  //     ),
                  //     leading: Icon(Icons.notifications),
                  //     dense: true,
                  //     trailing: Icon(
                  //       Icons.brightness_1,
                  //       size: 20.0,
                  //       color: Colors.red,
                  //     ),
                  //   ),
                  // ),
                  // ReuseInkwell.getItem(
                  //   _lang.translate('setting'),
                  //   () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, SettingView);
                  //   },
                  //   icon: Icon(Icons.settings),
                  // ),
                  // ReuseInkwell.getItem(
                  //   _lang.translate('logout_string'),
                  //   () async {
                  //     var isShow = await _pref.read('isshow');
                      
                  //     // Clear All Local Data
                  //     await AppServices.clearStorage();

                  //     // Save Carousel Screen
                  //     await _pref.saveString('isshow', isShow);
                  //     HomeDialog().alertDialog(context);
                  //     // Auth().signOut(context);
                  //   },
                  //   icon: Icon(Icons.input),
                  // ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}
