import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

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
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
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
    return Scaffold(
      body: NetworkAlert(
        _buildBody(),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddListingView);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => AddListing()));
        },
        backgroundColor: kDefaultColor,
        child: Icon(Icons.add),
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
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _selectedIndex == 2 ? kDefaultColor : _color,
                  size: 30,
                ),
                onPressed: () {
                  _onItemTapped(2);
                },
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
    );
  }
}
