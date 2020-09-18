import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class ReuseAuthTab extends StatelessWidget {
  final TabController _tabController;
  ReuseAuthTab(this._tabController);
  @override
  Widget build(BuildContext context) {
    return _tabBar();
  }
  Widget _tabBar() {
    return Container(
      width: 300.0,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
        color: Colors.white,
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: new BubbleTabIndicator(
          indicatorHeight: 40,
          indicatorRadius: kDefaultRadius,
          indicatorColor: kDefaultColor,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            child: Text('Phone'),
          ),
          Tab(
            child: Text('Email'),
          ),
        ],
      ),
    );
  }
}