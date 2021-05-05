import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ReuseAppBar {
  static getTitle(String title, context, appBarItemOne, appBarItemTwo,appBarItemThree, controller, {ShopProvider shopProvider, Function upLoadedProduct, bool enableAddIcon = false}) {
    return AppBar(
      toolbarHeight: 70,
      brightness: Brightness.light,
      titleSpacing: 0,
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
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(left: 25),
        icon: Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: AppServices.hexaCodeToColor(AppColors.primary),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        if (enableAddIcon) IconButton(
          padding: EdgeInsets.only(right: 25),
          icon: Icon(
            Icons.add,
            size: 40,
            color: AppServices.hexaCodeToColor(AppColors.primary),
          ),
          onPressed: () async {
            final response = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddListing(from: shopProvider.shopCheck == 'creating' ? 'fromCreateShop' : null,)));
            if (response != null ){
              upLoadedProduct(response);
            }
          },
        )
      ],
    );
  }
}
