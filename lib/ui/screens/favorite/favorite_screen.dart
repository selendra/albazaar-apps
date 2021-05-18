import 'package:albazaar_app/all_export.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/screens/favorite/components/body.dart';
import 'package:albazaar_app/core/constants/constants.dart';
import 'package:albazaar_app/core/services/app_localize_service.dart';

class FavoriteScreen extends StatelessWidget {

  final bool hasBackBtn;

  FavoriteScreen({
    this.hasBackBtn = false
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar().appBar(
          title: AppLocalizeService.of(context).translate('favorite'),
          leading: hasBackBtn == true ? GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: MyPadding(
              pLeft: 25, pRight: 10,
              child: SvgPicture.asset(AppConfig.iconPath+'back.svg')
            )
          ) 
          : MyPadding(
            pLeft: 25, pRight: 10,
            child: SvgPicture.asset(AppConfig.iconPath+'favorite.svg')
          )
        ),
        body: Body(),
      )
    );
  }
}
