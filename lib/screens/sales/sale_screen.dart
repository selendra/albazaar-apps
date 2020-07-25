import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_appbar.dart';
import 'package:selendra_marketplace_app/screens/sales/components/body.dart';


class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> with SingleTickerProviderStateMixin{

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this,length: 3);
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseAppBar.getTitle('Sales', context, 'Pending', 'Complete', 'All', _controller),
      body: Body(_controller),
    );
  }
}
