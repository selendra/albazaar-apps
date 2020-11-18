import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseAuthTab extends StatelessWidget {
  final TabController _tabController;
  final String firstTab;
  final String secondTab;
  ReuseAuthTab(this._tabController, this.firstTab, this.secondTab);
  @override
  Widget build(BuildContext context) {
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
            child: Text(
              firstTab,
              style: TextStyle(
                color: _tabController.index == 1 ? Colors.grey : Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              secondTab,
              style: TextStyle(
                color: _tabController.index == 0 ? Colors.grey : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
