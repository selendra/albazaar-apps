import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/app_services.dart';
class ReuseAuthTab extends StatelessWidget {

  final TabController _tabController;
  final String firstTab;
  final String secondTab;
  final Function onTap;
  
  ReuseAuthTab(this._tabController, this.firstTab, this.secondTab, this.onTap);
  @override
    Widget build(BuildContext context) {
      return Container(
        width: 200.0,
        // height: 50,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          color: Colors.white,
        ),
        child: TabBar(
          onTap: (int index){
            onTap(index);
          },
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppServices.hexaCodeToColor(AppColors.primary)
            // indicatorHeight: 40,
            // indicatorRadius: kDefaultRadius,
            // indicatorColor: kDefaultColor,
            // tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          tabs: [
            Tab(
              child: Text(
                firstTab,
              ),
            ),
            Tab(
              child: Text(
                secondTab,
              ),
            ),
          ],
        ),
      );
    }
}
