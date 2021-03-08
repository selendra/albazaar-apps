import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ReuseAppBar {
  static getTitle(String title, context, appBarItemOne, appBarItemTwo,appBarItemThree, controller) {
    return AppBar(
      toolbarHeight: 68,
      brightness: Brightness.light,
      titleSpacing: 20,
      // leadingWidth: 25,
      title: MyText(
        text: title,
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
        fontSize: 30,
      ),
      // bottom: ReuseTabBar.getItem(appBarItemOne, appBarItemTwo, appBarItemThree, controller, context),
      //  backgroundColor: Colors.white,
      leading: IconButton(
        padding: EdgeInsets.only(left: 25),
        icon: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: AppServices.hexaCodeToColor(AppColors.primary),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.only(right: 25),
          icon: Icon(
            Icons.add,
            size: 40,
            color: AppServices.hexaCodeToColor(AppColors.primary),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
