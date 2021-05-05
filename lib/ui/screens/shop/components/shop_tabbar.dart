import 'package:albazaar_app/all_export.dart';

class ShopTabbar extends StatelessWidget{

  final TabController tabController;

  final Function onTapTabBar;

  ShopTabbar({this.onTapTabBar, this.tabController});

  Widget build(BuildContext context){
    return MyPadding(
      pTop: pd20,
      pLeft: pd10+2, pRight: pd10+2,
      pBottom: pd20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 130,
            height: 60,
            decoration: BoxDecoration(
              color: AppServices.hexaCodeToColor(AppColors.secondary),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextButton(
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white),
                  MyText(
                    pLeft: 10,
                    fontSize: 16.0,
                    text: "Search",
                    color: AppColors.white,
                  )
                ],
              ),
            )
          ),

          Flexible(
            child: TabBar(
              labelPadding: EdgeInsets.zero,
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: new BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent
                // indicatorHeight: 40,
                // indicatorRadius: kDefaultRadius,
                // indicatorColor: kDefaultColor,
                // tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              unselectedLabelColor: Colors.black,
              labelColor: AppServices.hexaCodeToColor(AppColors.secondary),
              onTap: onTapTabBar,
              tabs: [
                Text(
                  "All",
                  style: TextStyle(
                    fontSize: 18
                  )
                ),
                
                Text(
                  "Pending",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                
                Text(
                  "Sold",
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
              ]
            )
          ),
          
        ],
      ),
    );
  }
}