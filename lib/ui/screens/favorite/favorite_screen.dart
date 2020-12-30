import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/favorite/components/body.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppLocalizeService.of(context).translate('favorite'),
            style: TextStyle(
              color: kDefaultColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          elevation: 0,
          // backgroundColor: Colors.white,
          leading: Icon(
            Icons.favorite,
            color: kDefaultColor,
          )),
      body: Responsive(
        mobile: Body(),
        desktop: ReuseDesktop(
          widget: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Body(),
          ),
        ),
      ),
    );
  }
}
