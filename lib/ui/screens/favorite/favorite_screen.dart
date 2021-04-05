import 'package:albazaar_app/all_export.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/screens/favorite/components/body.dart';
import 'package:albazaar_app/core/constants/constants.dart';
import 'package:albazaar_app/core/services/app_localize_service.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar().appBar(
          title: AppLocalizeService.of(context).translate('favorite'),
          leading: MyPadding(
            pLeft: 25, pRight: 10,
            child: SvgPicture.asset(AppConfig.iconPath+'favorite.svg')
          )
        ),
        body: Body(),
      )
    );
  }
}
