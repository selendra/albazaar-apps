import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

     String alertText;

    showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text('Ok'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(alertText),
      actions: <Widget>[
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  onfetchPortforlio(String _token) async {
    await ApiGetServices().fetchPortforlio(_token).then((value) {
      alertText = value;
      if(alertText!=''){
        showAlertDialog(context);
      }
    });
  }
  checkIsSocialLogIn()async{
    String _token;
    SharedPreferences isToken = await SharedPreferences.getInstance();
    _token = isToken.getString('token');
    if(_token!=null){
      onfetchPortforlio(_token);
    }else{
      alertText = 'Look like you don\'t have a wallet yet!';
      showAlertDialog(context);
    }
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
    checkIsSocialLogIn();
   
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddListing()));
        },
        backgroundColor: kDefualtColor,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _pageChange(index);
        },
        children: <Widget>[
          HomeScreen(),
          WalletScreen(),
          FavoriteScreen(),
          AccountScreen(),
        ],
      ),
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
                  color: _selectedIndex == 0 ? kDefualtColor : _color,
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
                  color: _selectedIndex == 1 ? kDefualtColor : _color,
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
                  color: _selectedIndex == 2 ? kDefualtColor : _color,
                  size: 30,
                ),
                onPressed: () {
                  _onItemTapped(2);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: _selectedIndex == 3 ? kDefualtColor : _color,
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
