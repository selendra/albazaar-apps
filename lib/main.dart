import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'constants.dart';
import 'screens/setting_screen.dart';
import 'screens/wallet_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyStatefulWidget(),
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  int _selectedIndex = 0;
  PageController _pageController;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WalletScreen(),
    SettingScreen(),
  ];

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

