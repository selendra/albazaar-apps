import 'package:flutter/material.dart';

import 'package:selendra_marketplace_app/all_export.dart';
import 'package:badges/badges.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';

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
      body: _buildBody(),
      bottomNavigationBar: Responsive.isDesktop(context)
          ? _buildBottomAppBarDesktop()
          : _buildBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, AddListingView)
              .then((value) async {
            if (value != null) {
              for (int i = 0;
                  i < addListData.addProduct.imageUrlList.length;
                  i++) {
                await PostRequest().addProductImage(
                    addListData.addProduct.imageUrlList[i],
                    addListData.addProduct.productId);
              }
            }
          });

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => AddListing()));
        },
        backgroundColor: kDefaultColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? kDefaultColor : _color,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _onItemTapped(0);
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.account_balance_wallet,
              color: _selectedIndex == 1 ? kDefaultColor : _color,
              size: 30,
            ),
            onPressed: () {
              _onItemTapped(1);
            },
          ),
          SizedBox.shrink(),
          Consumer<FavoriteProvider>(
            builder: (context, value, child) => value.items.length == 0
                ? IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 30,
                      color: _selectedIndex == 2 ? kDefaultColor : _color,
                    ),
                    onPressed: () {
                      _onItemTapped(2);
                    })
                : Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    animationDuration: Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      value.items.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 30,
                          color: _selectedIndex == 2 ? kDefaultColor : _color,
                        ),
                        onPressed: () {
                          _onItemTapped(2);
                        }),
                  ),
          ),
          IconButton(
            icon: Icon(
              Icons.location_on,
              color: _selectedIndex == 3 ? kDefaultColor : _color,
              size: 30,
            ),
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAppBarDesktop() {
    return Container(
      height: 40,
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Container(
            width: 800,
            color: Colors.transparent,
            child: BottomAppBar(
              elevation: 0,
              color: Colors.transparent,
              shape: CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: _selectedIndex == 0 ? kDefaultColor : _color,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        _onItemTapped(0);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_balance_wallet,
                      color: _selectedIndex == 1 ? kDefaultColor : _color,
                      size: 30,
                    ),
                    onPressed: () {
                      _onItemTapped(1);
                    },
                  ),
                  SizedBox.shrink(),
                  Consumer<FavoriteProvider>(
                    builder: (context, value, child) => value.items.length == 0
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite,
                              size: 30,
                              color:
                                  _selectedIndex == 2 ? kDefaultColor : _color,
                            ),
                            onPressed: () {
                              _onItemTapped(2);
                            })
                        : Badge(
                            position: BadgePosition.topEnd(top: 0, end: 3),
                            animationDuration: Duration(milliseconds: 300),
                            animationType: BadgeAnimationType.slide,
                            badgeContent: Text(
                              value.items.length.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: _selectedIndex == 2
                                      ? kDefaultColor
                                      : _color,
                                ),
                                onPressed: () {
                                  _onItemTapped(2);
                                }),
                          ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: _selectedIndex == 3 ? kDefaultColor : _color,
                      size: 30,
                    ),
                    onPressed: () {
                      _onItemTapped(3);
                    },
                  ),
                ],
              ),
            ),
          ),
          Flexible(flex: 2, child: Container()),
        ],
      ),
    );
  }
}
