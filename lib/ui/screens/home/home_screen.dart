
import 'package:albazaar_app/ui/screens/home/components/product_categories.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/home/components/body.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TabController _tabController;
  ScrollController _scrollController;

  final double pBottom = 20;
  final padding= 16.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController();

    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) async {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchListingProduct();
      Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
      await Provider.of<TrxHistoryProvider>(context, listen: false)
          .fetchTrxHistory();
    });
  }

  onTabChange() {
    _tabController.addListener(() {
      if (_tabController.index == 0){
        _scrollController.jumpTo(_scrollController.offset);
      print(_scrollController.keepScrollOffset);

      print(_scrollController.offset);
      print(_tabController.index);
      }
      // if (_tabController.index == 0)  _scrollController.initialScrollOffset;
    });
  }
  scrollListener() {
    _scrollController.addListener(() {
      print(_scrollController.keepScrollOffset);

      print(_scrollController.offset);
    });
  }

  onTapTab(int index, {PageController p, TabController t}) {
    onTabChange();
    setState(() {});
  }

  void resetState(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldState,
        body: BodyScaffold(
          physics: NeverScrollableScrollPhysics(),
          bottom: pBottom+pBottom,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [

              Container(
                height: 70,
                margin: EdgeInsets.only(bottom: 30),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NotificationScreen()));
                        // showSearch(context: context, delegate: SearchProducts());
                      },
                    )
                  ],
                )
              ),

              MyPadding(
                pLeft: padding, pRight: padding,
                pBottom: pBottom,
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
                        controller: _tabController,
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
                          
                          Text(
                            "Coupons",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ]
                      )
                    )
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Body(
                      scrollController: _scrollController,
                      refresh: _refresh,
                    ),
                    ProductCategories(
                      refresh: _refresh,
                    ),
                    Center(
                      child: MyText(text: "No Coupon")
                    ),
                  ],
                ),
              )
            ],
          ),
          // NestedScrollView(
          //   physics: NeverScrollableScrollPhysics(),
          //   headerSliverBuilder: (context, value){
          //     return HomeHeader().sliverHeader(
          //       context: context,
          //       tabController: _tabController,
          //       onTapTab: onTapTab,
          //     );
          //   },
          //   body: ,
          // )


          //     NestedScrollView(
          //   controller: scrollController,
          //   headerSliverBuilder: (BuildContext context, bool boxIsScroll) {
          //     return <Widget>[
          //       ,
          //     ];
          //   },
          //   body: Column(
          //     children: [

          //       MyPadding(
          //         pTop: padding,
          //         pLeft: padding, pRight: padding,
          //         pBottom: pBottom,
          //         child: Align(
          //           alignment: Alignment.centerLeft,  
          //           child: MyText(
          //             text: "Promo and Events",
          //             fontWeight: FontWeight.w600,
          //           )
          //         )
          //       ),

          //       MyPadding(
          //         pLeft: padding, pRight: padding,
          //         pBottom: pBottom,
          //         child: Container(
          //           height: 200,
          //           child: Row(
          //             children: [

          //               Expanded(
          //                 child: MyCard(
          //                   boxShadow:[
          //                     BoxShadow(
          //                       color: Colors.grey[300],
          //                       spreadRadius: 2.0,
          //                       offset: Offset(0,0),
          //                       blurRadius: 5.0,
          //                     )
          //                   ],
          //                   mRight: padding,
          //                   width: MediaQuery.of(context).size.width,
          //                   image: DecorationImage(
          //                     image: AssetImage(
          //                       'assets/promotion5.jpg'
          //                     ),
          //                     fit: BoxFit.cover
          //                   ),
          //                 )
          //               ),

          //               Flexible(
          //                 child: MyCard(
          //                   boxShadow:[
          //                     BoxShadow(
          //                       color: Colors.grey[300],
          //                       spreadRadius: 2.0,
          //                       offset: Offset(0,0),
          //                       blurRadius: 5.0,
          //                     )
          //                   ],
          //                   width: MediaQuery.of(context).size.width,
          //                   image: DecorationImage(
          //                     image: AssetImage(
          //                       'assets/promotion6.jpg',
          //                     ),
          //                     fit: BoxFit.cover
          //                   ),
          //                 )
          //               )
          //             ],
          //           ),
          //         ),
          //       ),

          //       MyPadding(
          //         pLeft: padding, pRight: padding,
          //         pBottom: pBottom,
          //         child: Row(
          //           children: [

          //             Container(
          //               height: 50,
          //               decoration: BoxDecoration(
          //                 color: AppServices.hexaCodeToColor(AppColors.secondary),
          //                 borderRadius: BorderRadius.circular(30.0),
          //               ),
          //               child: FlatButton(
          //                 color: Colors.transparent,
          //                 onPressed: (){},
          //                 child: Row(
          //                   children: [
          //                     Icon(Icons.search, color: Colors.white),
          //                     MyText(
          //                       pLeft: 10,
          //                       fontSize: 16.0,
          //                       text: "Search",
          //                       color: AppColors.white,
          //                     )
          //                   ],
          //                 ),
          //               )
          //             ),

          //             Expanded(
          //               child: MyText(
          //                 text: "All",
          //                 color: AppColors.secondary,
          //               )
          //             ),
                      
          //             Expanded(
          //               child: MyText(
          //                 text: "Categories"
          //               )
          //             ),
                      
          //             Flexible(
          //               child: MyText(
          //                 left: 10,
          //                 text: "Coupons"
          //               )
          //             ),
          //           ],
          //         ),
          //       ),

          //       MyPadding(
          //         pLeft: padding, pRight: padding,
          //         pBottom: pBottom,
          //         child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: MyText(
          //             text: "All Products",
          //             fontWeight: FontWeight.w600,
          //             fontSize: 20.0,
          //           )
          //         )
          //       ),

          //       listProduct == null ? CircularProgressIndicator()
          //       : Expanded(
          //         child: MyPadding(
          //           pLeft: 0, pRight: padding,
          //           pBottom: pd35+pd35,
          //           child: GridView.builder(
          //             itemCount: listProduct.length,//widget.productsData.length,
          //             controller: scrollController,
          //             shrinkWrap: true,
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               crossAxisSpacing: 0,
          //               childAspectRatio: 0.75,
          //             ),
          //             itemBuilder: (context, index) {
          //               return MyPadding(
          //                 pLeft: padding, pRight: 0,
          //                 pBottom: padding,
          //                 child: GestureDetector(
          //                   onTap: (){
          //                     Navigator.of(context).pushNamed(
          //                       '/detail',
          //                       arguments: listProduct[index],
          //                     );
          //                   },
          //                   child: MyCard(
          //                     align: Alignment.centerLeft,
          //                     child: Container(
          //                       // height: 235,
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [

          //                           // Flexible(
          //                           //   child: 
          //                             // FadeInImage(
          //                             //         fit: BoxFit.contain,
          //                             //         height: double.infinity,
          //                             //         width: double.infinity,
          //                             //         image: NetworkImage(listProduct[index].thumbnail),
          //                             //         placeholder: AssetImage('assets/loading.gif'),
          //                             //       )
          //                             // MyCard(
          //                             //   // height: 141,
          //                             //   width: double.infinity,
          //                             //   hexaColor: AppColors.cardTitleBG,
          //                             //   bBottomLeft: 0,
          //                             //   bBottomRight: 0,
          //                             //   align: Alignment.topCenter,
          //                             //   child: Stack(
          //                             //     children: [
          //                             //       // Center(
          //                             //       //   child: SvgPicture.asset('assets/avatar_user.svg'),
          //                             //       // ),
          //                             //       FadeInImage(
          //                             //         fit: BoxFit.contain,
          //                             //         height: double.infinity,
          //                             //         width: double.infinity,
          //                             //         image: NetworkImage(listProduct[index].thumbnail),
          //                             //         placeholder: AssetImage('assets/loading.gif'),
          //                             //       ),
          //                             //       Positioned(
          //                             //         right: 10, top: 10,
          //                             //         child: GestureDetector(
          //                             //           child: SvgPicture.asset('assets/icons/heart.svg'),
          //                             //         ),
          //                             //       )
          //                             //     ],
          //                             //   ),
          //                             // )
          //                           // ),
          //                           Flexible(
          //                             child: Hero(
          //                               tag: "${listProduct[index].id}",
          //                               child: MyCard(
          //                                 bBottomLeft: 0, bBottomRight: 0,
          //                                 image: DecorationImage(
          //                                   fit: BoxFit.cover,
          //                                   image: NetworkImage(listProduct[index].thumbnail) //CachedNetworkImageProvider(listProduct[index].thumbnail)
          //                                 ),
          //                               )
          //                             )
          //                           ),

          //                           MyCard(
          //                             align: Alignment.centerLeft,
          //                             bTopLeft: 0, bTopRight: 0,
          //                             mBottom: cPadding, mTop: cPadding, mLeft: cPadding, mRight: cPadding,
          //                             child: Column(
          //                               crossAxisAlignment: CrossAxisAlignment.start,
          //                               children: [

          //                                 Padding(
          //                                   padding: EdgeInsets.only(bottom: 5),
          //                                   child: Row(
          //                                     crossAxisAlignment: CrossAxisAlignment.center,
          //                                     children: [
          //                                       Expanded(
          //                                         child: MyText(
          //                                           textAlign: TextAlign.left,
          //                                           text: "${listProduct[index].name}",
          //                                           fontSize: 16,
          //                                           fontWeight: FontWeight.bold,
          //                                           color: "#000000",
          //                                         )
          //                                       ),
                                                
          //                                       MyText(
          //                                         text: "(0 sold)",
          //                                         fontSize: 12,
          //                                         color: "#000000",
          //                                       )
          //                                     ],
          //                                   )
          //                                 ),

          //                                 Padding(
          //                                   padding: EdgeInsets.only(bottom: 5),
          //                                   child: MyText(
          //                                     textAlign: TextAlign.left,
          //                                     text: "${listProduct[index].description}",
          //                                     fontSize: 16,
          //                                     color: "#000000",
          //                                     overflow: TextOverflow.ellipsis,
          //                                     maxLine: 1,
          //                                   )
          //                                 ),

          //                                 Padding(
          //                                   padding: EdgeInsets.only(bottom: 5),
          //                                   child: Row(
          //                                     children: [
          //                                       Image.asset('assets/symbols/riel_symbol.png', width: 9, height: 15),
          //                                       MyText(
          //                                         textAlign: TextAlign.left,
          //                                         text: "${listProduct[index].price} /Kg",
          //                                         fontSize: 16,
          //                                         fontWeight: FontWeight.bold,
          //                                         color: AppColors.primary,
          //                                         pLeft: 5,
          //                                       )
          //                                     ],
          //                                   )
          //                                 ),

          //                                 Row(
          //                                   children: [
          //                                     Padding(
          //                                       padding: EdgeInsets.only(right: 7),
          //                                       child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
          //                                     ),
          //                                     Padding(
          //                                       padding: EdgeInsets.only(right: 7),
          //                                       child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
          //                                     ),
          //                                     Padding(
          //                                       padding: EdgeInsets.only(right: 7),
          //                                       child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
          //                                     ),
          //                                     Padding(
          //                                       padding: EdgeInsets.only(right: 7),
          //                                       child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
          //                                     ),
          //                                     Padding(
          //                                       padding: EdgeInsets.only(right: 7),
          //                                       child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
          //                                     ),
          //                                     MyText(
          //                                       textAlign: TextAlign.left,
          //                                       text: "(15)",
          //                                       fontSize: 10,
          //                                       color: "#000000",
          //                                     )
          //                                   ],
          //                                 )
                                          
          //                               ],
          //                             ),
          //                           )
          //                         ],
          //                       )
          //                     ),
          //                   ),
          //                 )
          //               );
          //             }
          //             // ChangeNotifierProvider.value(
          //             //   value: widget.productsData[index],
          //             //   child: ItemCard(),
          //             // ),
          //           )
          //         )
          //       )
                
          //     ],
          //   ),
          // //   body: GestureDetector(
          // //     onTap: () => FocusManager.instance.primaryFocus.unfocus(),
          // //     child: Body()
          // //   ),
            
          // )
        ),
      )
    );
  }
}
