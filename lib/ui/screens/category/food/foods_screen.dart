import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class FoodsScreen extends StatefulWidget {
  final String _image;
  FoodsScreen(this._image);
  @override
  _FoodsScreenState createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 7);
    // Provider.of<ProductsProvider>(context, listen: false).getVegi();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var _lang = AppLocalizeService.of(context);
    // final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          widget._image,
          height: 30,
          width: 30,
        ),
        // bottom: TabBar(
        //   controller: controller,
        //   isScrollable: true,
        //   indicatorColor: kDefaultColor,
        //   unselectedLabelColor: Colors.grey,
        //   labelColor: kDefaultColor,
        //   labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        //   tabs: <Widget>[
        //     Tab(
        //       text: _lang.translate('all'),
        //     ),
        //     Tab(
        //       text: _lang.translate('meat'),
        //     ),
        //     Tab(
        //       text: _lang.translate('fruit'),
        //     ),
        //     Tab(
        //       text: _lang.translate('drinks'),
        //     ),
        //     Tab(
        //       text: _lang.translate('vegetable'),
        //     ),
        //     Tab(
        //       text: _lang.translate('seasoning'),
        //     ),
        //     Tab(
        //       text: _lang.translate('desserts'),
        //     )
        //   ],
        // ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDefaultColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: kDefaultColor,
            ),
            onPressed: () {
              print('search');
            },
          )
        ],
      ),
      body: Container(
        //child: ProductList(productsData.vegProduct),
        child: Container(),
      ), //_buildTapBarView(),
    );
  }

  // Widget _buildTapBarView() {
  //   return Container(
  //     width: double.infinity,
  //     child: TabBarView(
  //       controller: controller,
  //       children: <Widget>[
  //         Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'All',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'Meat',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'Fruit',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'Drinks',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'Vegatble',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'Seasoning',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'Desserts',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
