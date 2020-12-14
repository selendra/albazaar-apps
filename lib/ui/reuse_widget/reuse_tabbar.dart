import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseTabBar {
  static getItem(String itemOne, String itemtwo, String itemThree,
      TabController controller, context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      indicatorColor: kDefaultColor,
      unselectedLabelColor: Colors.grey,
      labelColor: kDefaultColor,
      labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      tabs: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Tab(
              text: itemOne,
            )),
        Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Tab(
              text: itemtwo,
            )),
        Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Tab(
              text: itemThree,
            )),
      ],
    );
  }
}
