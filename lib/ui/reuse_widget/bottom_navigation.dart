import 'package:flutter/material.dart';

import 'package:albazaar_app/all_export.dart';
import 'package:badges/badges.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  PageController _pageController;
  int currentIndex = 0;
  Color _color = Colors.grey;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      },
    );
  }

  void _pageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    final addListData = Provider.of<AddProductProvider>(context);
    // print(addListData.addProduct.imageUrlList);
    // print("My Product id ${addListData.addProduct.productId}");
    return Scaffold(
      key: scaffoldKey,
      drawer: HomeDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomAppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await Navigator.pushNamed(context, AddListingView)
      //         .then((value) async {
      //       if (value != null) {
      //         for (int i = 0;
      //             i < addListData.addProduct.imageUrlList.length;
      //             i++) {
      //           await PostRequest().addProductImage(
      //               addListData.addProduct.imageUrlList[i],
      //               addListData.addProduct.productId);
      //         }
      //       }
      //     });

      //     // Navigator.push(
      //     //     context, MaterialPageRoute(builder: (context) => AddListing()));
      //   },
      //   backgroundColor: kDefaultColor,
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        _pageChange(index);
      },
      children: <Widget>[
        HomeScreen(),
        WalletScreen(),
        FavoriteScreen(),
        MapScreen(),
      ],
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _onItemTapped(0);
                    });
                  },
                  child:  Column(
                    children: [
                      Divider(color: _selectedIndex == 0 ? AppServices.hexaCodeToColor(AppColors.primary) : Colors.transparent, thickness: 3, height: 2,),
                      Expanded(
                        child: SvgPicture.asset('assets/icons/market.svg', width: 30, height: 30, color: AppServices.hexaCodeToColor(_selectedIndex == 0 ? AppColors.black : AppColors.primary)),
                      )
                    ],
                  )
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _onItemTapped(1);
                    });
                  },
                  child:  Column(
                    children: [
                      Divider(color: _selectedIndex == 1 ? AppServices.hexaCodeToColor(AppColors.primary) : Colors.transparent, thickness: 3, height: 2,),
                      Expanded(
                        child: SvgPicture.asset('assets/icons/wallet.svg', width: 30, height: 30, color: AppServices.hexaCodeToColor(_selectedIndex == 1 ? AppColors.black : AppColors.primary),),
                      )
                    ],
                  )
                )
              ),

              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _onItemTapped(2);
                    });
                  },
                  child:  Column(
                    children: [
                      Divider(color: _selectedIndex == 2 ? AppServices.hexaCodeToColor(AppColors.primary) : Colors.transparent, thickness: 3, height: 2,),
                      Expanded(
                        child: SvgPicture.asset('assets/icons/favorite.svg', width: 30, height: 30, color: AppServices.hexaCodeToColor(_selectedIndex == 2 ? AppColors.black : AppColors.primary),),
                      )
                    ],
                  )
                )
              ),

              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _onItemTapped(3);
                    });
                  },
                  child:  Column(
                    children: [
                      Divider(color: _selectedIndex == 3 ? AppServices.hexaCodeToColor(AppColors.primary) : Colors.transparent, thickness: 3, height: 2,),
                      Expanded(
                        child: SvgPicture.asset('assets/icons/location.svg', width: 30, height: 30, color: AppServices.hexaCodeToColor(_selectedIndex == 3 ? AppColors.black : AppColors.primary),),
                      )
                    ],
                  )
                )
              ),

              Expanded(
                child: GestureDetector(
                  onTap: (){
                    scaffoldKey.currentState.openDrawer();
                  },
                  child: SvgPicture.asset('assets/icons/menu.svg'),
                )
              )
            ],
          )
        ),
      );
    // BottomAppBar(
    //   shape: CircularNotchedRectangle(),
    //   child: Container(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           IconButton(
    //             icon: Icon(
    //               Icons.home,
    //               color: _selectedIndex == 0 ? kDefaultColor : _color,
    //               size: 30,
    //             ),
    //             onPressed: () {
    //             },
    //           ),
    //           IconButton(
    //             icon: Icon(
    //               Icons.account_balance_wallet,
    //               color: _selectedIndex == 1 ? kDefaultColor : _color,
    //               size: 30,
    //             ),
    //             onPressed: () {
    //               _onItemTapped(1);
    //             },
    //           ),
    //           SizedBox.shrink(),
    //           Consumer<FavoriteProvider>(
    //             builder: (context, value, child) => value.items.length == 0
    //                 ? IconButton(
    //                     icon: Icon(
    //                       Icons.favorite,
    //                       size: 30,
    //                       color: _selectedIndex == 2 ? kDefaultColor : _color,
    //                     ),
    //                     onPressed: () {
    //                       _onItemTapped(2);
    //                     })
    //                 : Badge(
    //                     position: BadgePosition.topEnd(top: 0, end: 3),
    //                     animationDuration: Duration(milliseconds: 300),
    //                     animationType: BadgeAnimationType.slide,
    //                     badgeContent: Text(
    //                       value.items.length.toString(),
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                     child: IconButton(
    //                         icon: Icon(
    //                           Icons.favorite,
    //                           size: 30,
    //                           color:
    //                               _selectedIndex == 2 ? kDefaultColor : _color,
    //                         ),
    //                         onPressed: () {
    //                           _onItemTapped(2);
    //                         }),
    //                   ),
    //           ),
    //           IconButton(
    //             icon: Icon(
    //               Icons.location_on,
    //               color: _selectedIndex == 3 ? kDefaultColor : _color,
    //               size: 30,
    //             ),
    //             onPressed: () {
    //               _onItemTapped(3);
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
