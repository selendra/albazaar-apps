import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  List<Map<String, dynamic>> items;

  bool _isTouchIdOn = false;
  bool _isPinOn = false;

  void checkTouchID() {
    setState(() {
      _isTouchIdOn = !_isTouchIdOn;
      if (_isTouchIdOn == true) {
      } else {
      }
    });
  }

  void checkPin() {
    setState(() {
      _isPinOn = !_isPinOn;
      if (_isPinOn == true) {
      } else {
      }
    });
  }

  @override
  initState(){
    items = [
      // General
      {
        "title": "language", "icon": "${AppConfig.iconPath}change_language.svg", 
        "action": () async {
          final response = await MyBottomSheet().changeLangauge(context: context);
        }
      },
      {
        "title": "currency", "icon": "${AppConfig.iconPath}currency.svg", 
        "action": () async {
          final response = await MyBottomSheet().changeCurrency(context: context);
        }
      },

      // Security
      {
        "title": "touch_id", "icon": "${AppConfig.iconPath}finger_print.svg", 
        "action": () async {
          // final response = await MyBottomSheet().changeLangauge(context: context);
          checkTouchID();
        }
      },

      /// Reset
      {
        "title": "reset_password", "icon": "${AppConfig.iconPath}reset_password.svg", 
        "action": () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassPhone()));
          // final response = await MyBottomSheet().changeLangauge(context: context);
        }
      },
      {
        "title": "reset_pin", "icon": "${AppConfig.iconPath}pin.svg", 
        "action": () async {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => Re()));
          // final response = await MyBottomSheet().changeLangauge(context: context);
        }
      },

    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(AppLocalizeService.of(context).translate('setting'), context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.only(left: 25, top: 15, bottom: 15, right: 15,),
        child: Column(
          children: <Widget>[
            
            Container(
              color: Colors.grey[200],
              child: ListTile(
                title: Text(
                  _lang.translate('general'),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            for(int i = 0; i < 2; i++)
            MyFlatButton(
              borderRadius: 0,
              action: items[i]['action'],
              buttonColor: AppColors.white,
              child: MyPadding(
                pLeft: 25, pTop: 15, pBottom: 15, pRight: 15,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 50,
                      child: SvgPicture.asset("${items[i]['icon']}", color: AppServices.hexaCodeToColor(AppColors.primary), width: 30, height: 30),
                    ),
                    MyText(text: _lang.translate('${items[i]['title']}'), textAlign: TextAlign.left),

                    Expanded(child: Container(),),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kDefaultColor,
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: ListTile(
                title: Text(
                  _lang.translate('security'),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),

            Container(
              color: Colors.white,
              child: MyPadding(
                pLeft: 25, pTop: 15, pBottom: 15, pRight: 15,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 50,
                      child: SvgPicture.asset("${items[2]['icon']}", color: AppServices.hexaCodeToColor(AppColors.primary), width: 30, height: 30),
                    ),
                    MyText(text: _lang.translate('${items[2]['title']}'), textAlign: TextAlign.left, fontWeight: FontWeight.bold,),

                    Expanded(child: Container(),),
                    Container(
                      height: 50, width: 50,
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        // title: MyText(text: _lang.translate('${items[2]['title']}'), textAlign: TextAlign.left, fontWeight: FontWeight.bold,),
                        value: _isTouchIdOn,
                        activeColor: AppServices.hexaCodeToColor(AppColors.primary),
                        activeTrackColor: AppServices.hexaCodeToColor(AppColors.primary),
                        onChanged: (value) {
                          checkTouchID();
                        },
                        // secondary: SvgPicture.asset("${items[2]['icon']}", width: 30, height: 30),
                      ),
                    )
                  ],
                )
              ),
            ),
            
            for(int i = 3; i < items.length; i++)
            MyFlatButton(
              borderRadius: 0,
              action: items[i]['action'],
              // () {
              //   // Navigator.pushNamed(context, ResetChoiceView);
              // },
              buttonColor: AppColors.white,
              child: MyPadding(
                pLeft: 25, pTop: 15, pBottom: 15, pRight: 15,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 50,
                      child: SvgPicture.asset("${items[i]['icon']}", color: AppServices.hexaCodeToColor(AppColors.primary), width: 30, height: 30),
                    ),
                    MyText(text: _lang.translate('${items[i]['title']}'), textAlign: TextAlign.left),

                    Expanded(child: Container(),),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kDefaultColor,
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   child: SwitchListTile(
            //     title: Text('PIN Code'),
            //     value: _isPinOn,
            //     activeColor: AppServices.hexaCodeToColor(AppColors.primary),
            //     activeTrackColor: AppServices.hexaCodeToColor(AppColors.primary),
            //     onChanged: (value) {
            //       checkPin();
            //     },
            //     secondary: SvgPicture.asset("${AppConfig.iconPath}change_language.svg", width: 30, height: 30),
            //   ),
            // ),

            Container(
              color: Colors.grey[200],
              child: ListTile(
                title: Text(
                  _lang.translate('version'),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            Container(
              
              alignment: Alignment.centerLeft,
              child: MyText(
                text: '1.0.0',
                pLeft: 35, pBottom: 15, pRight: 15,
                color: AppColors.primary,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
