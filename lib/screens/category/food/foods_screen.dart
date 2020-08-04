import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';


class FoodsScreen extends StatefulWidget {
  @override
  _FoodsScreenState createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller  = TabController(vsync: this,length: 7);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Icon(Icons.restaurant,color: kDefualtColor,),
        bottom: TabBar(
          controller: controller,
          isScrollable: true,
          indicatorColor: kDefualtColor,
          unselectedLabelColor: Colors.grey,
          labelColor: kDefualtColor,
          labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
          tabs: <Widget>[
            Tab(text: 'All',),
            Tab(text: 'Meat',),
            Tab(text: 'Fruit',),
            Tab(text: 'Drinks',),
            Tab(text: 'Vegtable',),
            Tab(text: 'Seasoning',),
            Tab(text: 'Desserts',)
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: kDefualtColor,),onPressed: (){
          Navigator.pop(context);
        },),
        actions: <Widget>[   
          IconButton(icon: Icon(Icons.search,color: kDefualtColor,),onPressed: (){print('search');},)
        ],
      ),
      body: _buildTapBarView(),
    );
  }
  Widget _buildTapBarView(){
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: controller,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pending',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Complete',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
  
}