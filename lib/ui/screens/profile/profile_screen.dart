import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/profile/components/body.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_simple_appbar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Profile', context),
      body: Body(),
    );
  }
}
