import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/home/components/body.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  ScrollController scrollController;
  String imgUrl = mUser.profileImg;

  String userName = mUser.firstName + ' ' + mUser.midName + mUser.lastName;

  String email;

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
      key: _scaffoldState,
      body: _buildAppBar(),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: kDefaultColor),
            currentAccountPicture: CircleAvatar(
              backgroundImage: imgUrl == null
                  ? AssetImage('images/avatar.png')
                  : NetworkImage(imgUrl),
            ),
            accountEmail: Text(mUser.email ?? 'Email'),
            accountName: Text(userName),
          ),
          ReuseInkwell.getItem('Home', Icons.home, () {
            Navigator.pop(context);
          }),
          ReuseInkwell.getItem('Profile', Icons.person, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          }),
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          ReuseInkwell.getItem('Purchase', Icons.shopping_basket, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PurchaseScreen()));
          }),
          ReuseInkwell.getItem('Listing', Icons.list, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListingScreen()));
          }),
          ReuseInkwell.getItem('Sale', Icons.monetization_on, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SalesScreen()));
          }),
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey[300],
          ),
          ReuseInkwell.getItem('Message', Icons.message, () {}),
          ReuseInkwell.getItem('Notification', Icons.notifications, () {}),
          ReuseInkwell.getItem('Settings', Icons.settings, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingScreen()));
          }),
          ReuseInkwell.getItem('Sign Out', Icons.input, () {
            signOut(context);
          }),
        ],
      ),
    );
  }

  Widget listTile(String title, IconData _iconData, Function _tap) {
    return ListTile(
      title: Text(title),
      leading: Icon(_iconData),
      onTap: _tap,
      contentPadding: EdgeInsets.all(0),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
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
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: kDefaultColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      child:
                          Image.asset('images/logo.png', width: 30, height: 30),
                      padding: EdgeInsets.only(right: 5)),
                  Text(
                    'SELENDRA',
                    style: TextStyle(
                      color: kDefaultColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: kDefaultColor,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                ),
              ],
            ),
          ];
        },
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus.unfocus(),
            child: Body()),
      ),
    );
  }
}
