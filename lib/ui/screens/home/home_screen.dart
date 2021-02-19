import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/core/components/card_c.dart';
import 'package:selendra_marketplace_app/core/components/scaffold.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';
import 'package:selendra_marketplace_app/ui/screens/home/components/body.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:badges/badges.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  ScrollController scrollController;
  final double padding = 16;
  final double pBottom = 20;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppServices.hexaCodeToColor("#F1F0F0"),
      key: _scaffoldState,
      body: _buildAppBar(),
      drawer: HomeDrawer(),
    );
  }

  Widget _buildAppBar() {
    return MyBodyScaffold(
      height: MediaQuery.of(context).size.height,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScroll) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              primary: true,
              forceElevated: boxIsScroll,
              brightness: Brightness.light,
              elevation: 0,
              // leading: IconButton(
              //   icon: Icon(
              //     Icons.menu,
              //     color: kDefaultColor,
              //   ),
              //   onPressed: () {
              //     // Scaffold.of(context).openDrawer();
              //   },
              // ),
              // flexibleSpace: FlexibleSpaceBar(
              //   titlePadding: EdgeInsets.zero,
              //   centerTitle: true,
              //   title: Row(
              //     children: [
              //       Flexible(p
              //         // flex: 1,
              //         child: Text("Should be centered", textAlign: TextAlign.center),
              //       )
              //     ],
              //   ),
              // ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: SvgPicture.asset('images/sld_logo.svg', width: 35, height: 47),
                    padding: EdgeInsets.only(left: 25, right: 10)
                  ),

                  Text(
                    'Marketplace',
                    style: TextStyle(
                      color: kDefaultColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
              toolbarHeight: 70,
              actions: <Widget>[
                // Consumer<CartProvider>(
                //   builder: (context, value, child) => value.items.length == 0
                //       ? IconButton(
                //           icon: Icon(
                //             Icons.shopping_cart,
                //             color: kDefaultColor,
                //           ),
                //           onPressed: () {
                //             Navigator.pushNamed(context, CartView);
                //           })
                //       : Badge(
                //           position: BadgePosition.topEnd(top: 0, end: 3),
                //           animationDuration: Duration(milliseconds: 300),
                //           animationType: BadgeAnimationType.scale,
                //           badgeContent: Text(
                //             value.items.length.toString(),
                //             style: TextStyle(color: Colors.white),
                //           ),
                //           child: IconButton(
                //               icon: Icon(
                //                 Icons.shopping_cart,
                //                 color: kDefaultColor,
                //               ),
                //               onPressed: () {
                //                 // Navigator.pushNamed(context, CartView);
                //               }),
                //         ),
                // ),

                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: SvgPicture.asset('images/icons/cart.svg'),
                    onPressed: () {
                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartScreen()));*/
                      // showSearch(context: context, delegate: SearchProducts());
                    },
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: kDefaultColor,
                    ),
                    onPressed: () {
                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartScreen()));*/
                      // showSearch(context: context, delegate: SearchProducts());
                    },
                  )
                ),
              ],
            ),
          ];
        },
        body: Column(
          children: [
            PaddingScaffold(
              pTop: padding,
              pLeft: padding, pRight: padding,
              pBottom: pBottom,
              child: Align(
                alignment: Alignment.centerLeft,  
                child: MyText(
                  text: "Promo and Events",
                  fontWeight: FontWeight.w600,
                )
              )
            ),

            PaddingScaffold(
              pLeft: padding, pRight: padding,
              pBottom: pBottom,
              child: Container(
                height: 200,
                child: Row(
                  children: [

                    Expanded(
                      child: MyCard(
                        mRight: padding,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                        )
                      )
                    ),

                    Flexible(
                      child: MyCard(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                        )
                      )
                    )
                  ],
                ),
              ),
            ),

            PaddingScaffold(
              pLeft: padding, pRight: padding,
              pBottom: pBottom,
              child: Row(
                children: [

                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppServices.hexaCodeToColor(AppColors.secondary),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: FlatButton(
                      color: Colors.transparent,
                      onPressed: (){},
                      child: Row(
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

                  Expanded(
                    child: MyText(
                      // pLeft: 20, pRight: 20,
                      // width: 29,
                      text: "All",
                      color: AppColors.secondary,
                    )
                  ),
                  
                  Expanded(
                    child: MyText(
                      text: "Categories"
                    )
                  ),
                  
                  Flexible(
                    child: MyText(
                      left: 10,
                      text: "Coupons"
                    )
                  ),
                ],
              ),
            ),

            PaddingScaffold(
              pLeft: padding, pRight: padding,
              pBottom: pBottom,
              child: Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: "All Products",
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                )
              )
            ),

            PaddingScaffold(
              pLeft: padding, pRight: padding,
              pBottom: pBottom,
              child: MyCard(
                align: Alignment.centerLeft,
                child: Container(
                  width: 181,
                  height: 235,
                  child: Column(
                    children: [
                      MyCard()
                    ],
                  )
                ),
              ),
            )
            
          ],
        ),
      //   body: GestureDetector(
      //     onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      //     child: Body()
      //   ),
        
      ),
    );
  }
}
