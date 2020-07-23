import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/purchase/components/body.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_appbar.dart';


class PurchaseScreen extends StatefulWidget {

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> with SingleTickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController (vsync: this, length: 3);
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
      appBar: ReuseAppBar.getTitle('Purchase', context,'Pending','Complete','All',_controller),
      body: Body(_controller),
    );
  }
}
