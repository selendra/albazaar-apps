import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/home/components/body.dart';
import 'package:selendra_marketplace_app/screens/home/components/search.dart';
import 'package:selendra_marketplace_app/screens/cart/cart.dart';
import 'package:selendra_marketplace_app/constants.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TabController controller;
  ScrollController scrollController;
  String myEmail;
  String myName;
  String myImageUrl;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 7);
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
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
              forceElevated: boxIsScroll,
              brightness: Brightness.light,
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              leading: IconButton(icon: Icon(Icons.language,color: kDefualtColor,),onPressed: (){},),
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
                  icon: Icon(Icons.search,color:kDefualtColor,),
                  onPressed: (){
                    showSearch(context: context, delegate: SearchProducts());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart,color: kDefualtColor,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                  },
                ),
              ],
            ),
          ];
        },
        body: Body(controller),
      ),
    );
  }

 
}
