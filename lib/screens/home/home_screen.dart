import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/home/components/body.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/home/components/search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TabController controller;
  ScrollController scrollController;
  List<Tab> tabs = [];
  List<String> titles = ['Fruits','Vegetable','Housing','Ingredients','Crops','Lands'];

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 6);
    scrollController = ScrollController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: _buildDrawer(),
      body: _buildAppBar(),

    );
  }

  Widget _buildAppBar(){
    return SafeArea(
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context,bool boxIsScroll){
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              primary: true,
              centerTitle: true,
              forceElevated: boxIsScroll,
              brightness: Brightness.light,
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'SELENDRA',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search,color: kDefualtColor,),
                  onPressed: (){
                    showSearch(context: context, delegate: SearchProducts());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart,color: kDefualtColor,),
                  onPressed: (){
                    print('Shopping Cart');
                  },
                ),
              ],
              leading: IconButton(
                icon: Icon(Icons.menu,color: kDefualtColor,),
                onPressed: (){
                  _scaffoldState.currentState.openDrawer();
                },
              ),
              bottom: TabBar(
                controller: controller,
                isScrollable: true,
                indicatorColor: kDefualtColor,
                unselectedLabelColor: Colors.grey,
                labelColor: kDefualtColor,
                labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                tabs: <Widget>[
                  Tab(text:'Fruits',),
                  Tab(text:'Vegetable',),
                  Tab(text:'Housing',),
                  Tab(text:'Ingredient',),
                  Tab(text:'Crops',),
                  Tab(text:'Lands',),
                ],
              ),
            ),
          ];
        },
        body: Body(controller),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Selendra Marketplace'),
            accountEmail: Text('selendramarketplace@email.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('S'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title:Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
            onTap: (){
              print('Home');
            },
          ),//Home
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title:Text(
              'Add a Listing',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
            onTap: (){
              print('Add a Listing');
            },
          ),//Add a List
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title:Text(
              'Purchases',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            onTap: (){
              print('Purchases');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title:Text(
              'Listing',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            onTap: (){
              print('Listing');
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title:Text(
              'Sales',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            onTap: (){
              print('Sales');
            },
          ),
          Container(
            height: 2,
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(Icons.message),
            title:Text(
              'Messages',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            onTap: (){
              print('Messages');
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title:Text(
              'Notification',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            onTap: (){
              print('Messages');
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title:Text(
              'Help',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            onTap: (){
              print('Help');
            },
          ),
          ListTile(
            leading: Icon(Icons.input),
            title:Text(
              'Sign Out',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
            onTap: (){
              print('Sign Out');
            },
          ),
        ],
      ),
    );
  }
}
