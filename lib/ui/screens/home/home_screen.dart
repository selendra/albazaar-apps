import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/ui/screens/home/components/body.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:badges/badges.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  ScrollController scrollController;

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
      drawer: HomeDrawer(),
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
                      padding: const EdgeInsets.only(right: 5)),
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
                Consumer<CartProvider>(
                  builder: (context, value, child) => value.items.length == 0
                      ? IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: kDefaultColor,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, CartView);
                          })
                      : Badge(
                          position: BadgePosition.topEnd(top: 0, end: 3),
                          animationDuration: Duration(milliseconds: 300),
                          animationType: BadgeAnimationType.scale,
                          badgeContent: Text(
                            value.items.length.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: kDefaultColor,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, CartView);
                              }),
                        ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: kDefaultColor,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: SearchProducts());
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
