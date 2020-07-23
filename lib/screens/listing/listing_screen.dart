import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/listing/components/body.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_appbar.dart';
import 'package:selendra_marketplace_app/constants.dart';

class ListingScreen extends StatefulWidget {

  @override
  _ListingScreenState createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> with SingleTickerProviderStateMixin{

  TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController (vsync: this,length: 3);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseAppBar.getTitle('Listing', context, 'Pending', 'Complete', 'All', _controller),
      body: Body(_controller),
    );
  }
}
