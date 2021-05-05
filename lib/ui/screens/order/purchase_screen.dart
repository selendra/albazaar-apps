import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/order/components/body.dart';
import 'package:albazaar_app/ui/reuse_widget/reuse_appbar.dart';
import 'package:albazaar_app/core/services/app_localize_service.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> with SingleTickerProviderStateMixin {

  TabController _controller;

  var result;

  void onTapTab(int index){
    _controller.addListener(() {
      // print("INdex" +_tabController.index.toString());
      setState(() {});
      // print()
      // if (_tabController.index == 0){
      //   _scrollController.jumpTo(_scrollController.offset);
      // print(_scrollController.keepScrollOffset);

      // print(_scrollController.offset);
      // print(_tabController.index);
      // }
      // if (_tabController.index == 0)  _scrollController.initialScrollOffset;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseAppBar.getTitle(
        _lang.translate('order'),
        context,
        _lang.translate('all_buyer'),
        _lang.translate('pending'),
        _lang.translate('complete'),
        _controller,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 300,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppServices.hexaCodeToColor(AppColors.white),
                  boxShadow: [
                    boxShadow()
                  ],
                  borderRadius: BorderRadius.circular(12)
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.only(top: 6, bottom: 6, right: 0, left: 0),
                  controller: _controller,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: new BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppServices.hexaCodeToColor(AppColors.primary)
                    // indicatorHeight: 40,
                    // indicatorRadius: kDefaultRadius,
                    // indicatorColor: kDefaultColor,
                    // tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  unselectedLabelColor: AppServices.hexaCodeToColor(AppColors.lowBlack),
                  labelColor: AppServices.hexaCodeToColor(AppColors.white),
                  onTap: onTapTab,
                  tabs: [

                    Text(
                      "All",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    
                    Text(
                      "Pending",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    
                    Text(
                      "Complete",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                  ]
                ),
              ),
            ),
            
            Expanded(
              child: BodyScaffold(
                height: MediaQuery.of(context).size.height,
                physics: NeverScrollableScrollPhysics(),
                top: 12,
                left: 12, right: 12,
                child: Body(_controller),
              ),
            )
          ],
        ),
      ),
    );
  }
}
