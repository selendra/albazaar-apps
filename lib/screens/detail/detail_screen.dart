import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return NestedScrollView(
      headerSliverBuilder: (context,innerBoxIsScrolled){
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: kDefualtColor,
            ),
              expandedHeight: MediaQuery.of(context).size.height/2,
            floating: true,
            pinned: true,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('images/pineapple.jpg',fit: BoxFit.fill,),
            ),
          ),
        ];
      },
      body: Center(
        child: Text('Sample Text'),
      )
    );
  }
}
