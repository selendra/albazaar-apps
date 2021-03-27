import 'package:albazaar_app/all_export.dart';

class HomeHeader{

  final double cPadding = 10;
  final double padding = 16;
  
  List<Widget> sliverHeader({
    BuildContext  context,
    TabController tabController,
    Function onTapTab,
    Function refresh
  }){
    return [
      SliverPersistentHeader(
        pinned: true,
        delegate: MySliverAppBarDelegate(
          minHeight: 70,
          maxHeight: 70,
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 20),
            color: Colors.white,
            child:  Row(
              children: <Widget>[
                Padding(
                  child: SvgPicture.asset('assets/sld_logo.svg', width: 35, height: 47),
                  padding: EdgeInsets.only(right: 10)
                ),

                Text(
                  'Albazaar',
                  style: TextStyle(
                    color: kDefaultColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Expanded(child: Container()),

                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: SvgPicture.asset('assets/icons/cart.svg'),
                    onPressed: () {
                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartScreen()));*/
                      // showSearch(context: context, delegate: SearchProducts());
                    },
                  )
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/belt.svg'),
                  onPressed: () {
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));*/
                    // showSearch(context: context, delegate: SearchProducts());
                  },
                )
              ],
            )
          )
        )
      ),

      // SliverPersistentHeader(
      //   pinned: false,
      //   delegate: MySliverAppBarDelegate(
      //     minHeight: 270,
      //     maxHeight: 270,
      //     child: Container(
      //       margin: EdgeInsets.only(top: 25),
      //       child: Column(
      //       children: [
      //         MyPadding(
      //           pLeft: padding, pRight: padding,
      //           pBottom: pBottom,
      //           child: Align(
      //             alignment: Alignment.centerLeft,  
      //             child: MyText(
      //               text: "Promo and Events",
      //               fontWeight: FontWeight.w600,
      //             )
      //           )
      //         ),

      //         MyPadding(
      //           pLeft: padding, pRight: padding,
      //           child: Container(
      //             height: 200,
      //             child: Row(
      //               children: [

      //                 Expanded(
      //                   child: MyCard(
      //                     boxShadow:[
      //                       BoxShadow(
      //                         color: Colors.grey[300],
      //                         spreadRadius: 2.0,
      //                         offset: Offset(0,0),
      //                         blurRadius: 5.0,
      //                       )
      //                     ],
      //                     mRight: padding,
      //                     width: MediaQuery.of(context).size.width,
      //                     image: DecorationImage(
      //                       image: AssetImage(
      //                         'assets/promotion5.jpg'
      //                       ),
      //                       fit: BoxFit.cover
      //                     ),
      //                   )
      //                 ),

      //                 Flexible(
      //                   child: MyCard(
      //                     boxShadow:[
      //                       BoxShadow(
      //                         color: Colors.grey[300],
      //                         spreadRadius: 2.0,
      //                         offset: Offset(0,0),
      //                         blurRadius: 5.0,
      //                       )
      //                     ],
      //                     width: MediaQuery.of(context).size.width,
      //                     image: DecorationImage(
      //                       image: AssetImage(
      //                         'assets/promotion6.jpg',
      //                       ),
      //                       fit: BoxFit.cover
      //                     ),
      //                   )
      //                 )
      //               ],
      //             ),
      //           )
      //         )
      //       ]
      //     ),
      //     )
      //   )
      // ),

      SliverPersistentHeader(
        pinned: true,
        delegate: MySliverAppBarDelegate(
          minHeight: 90.0,
          maxHeight: 90.0,
          child: Container(
            color: AppServices.hexaCodeToColor(AppColors.bgColor),
            child: MyPadding(
              pLeft: padding, pRight: padding,
              // pBottom: pBottom,
              child: Row(
                children: [

                  Container(
                    width: 130,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppServices.hexaCodeToColor(AppColors.secondary),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: MyFlatButton(
                      isTransparent: true,
                      action: () async {
                        final query = await showSearch(context: context, delegate: ProductSearch() );
                      },
                      height: double.infinity,
                      width: null,
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
                      onTap: onTapTab,
                      tabs: [
                        Text(
                          "All",
                          style: TextStyle(
                            fontSize: 18
                          )
                        ),
                        
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        
                        Flexible(
                          child: Text(
                            "Coupons",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        )
                      ]
                    )
                  )
                ],
              ),
            )
          ),
        ),
      ),

      // SliverPersistentHeader(
      //   pinned: true,
      //   delegate: MySliverAppBarDelegate(
      //     minHeight: 50,
      //     maxHeight: 50,
      //     child: Container(
      //       color: AppServices.hexaCodeToColor(AppColors.bgColor),
      //       child: MyPadding(
      //         pLeft: padding, pRight: padding,
      //         child: Align(
      //           alignment: Alignment.topLeft,
      //           child: MyText(
      //             text: "All Products",
      //             fontWeight: FontWeight.w600,
      //             fontSize: 20.0,
      //           )
      //         )
      //       )
      //     )
      //   ),
      // )
  ] ;
  }
}