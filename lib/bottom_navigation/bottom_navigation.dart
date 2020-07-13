import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/home/home_screen.dart';
import 'package:selendra_marketplace_app/screens/wallet/wallet_screen.dart';
import 'package:selendra_marketplace_app/screens/setting/setting_screen.dart';
import 'package:selendra_marketplace_app/constants.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BottomNavigation> {

  int _selectedIndex = 0;
  PageController _pageController;



  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }
  void _pageChange(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: _buildBody()
      ),
      bottomNavigationBar: _buildBottomNavigate(),
    );
  }
  Widget _buildBody(){
    return SizedBox.expand(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index){
          _pageChange(index);
        },
        children: <Widget>[
          HomeScreen(),
          WalletScreen(),
          SettingScreen(),
        ],
      ),
    );
  }
  Widget _buildBottomNavigate (){
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text('',style: TextStyle(fontSize: 0),),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text('',style: TextStyle(fontSize: 0),),
          icon: Icon(Icons.account_balance_wallet),
        ),
        BottomNavigationBarItem(
          title: Text('',style: TextStyle(fontSize: 0),),
          icon: Icon(Icons.settings),
        ),
      ],
      selectedItemColor: kDefualtColor,
      onTap: _onItemTapped,
    );
  }
}