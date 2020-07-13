import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/setting/components/body.dart';

class SettingScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Body(),
    );
  }

  Widget _buildAppBar (){
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Text('Settings',style: TextStyle(fontWeight: FontWeight.w600,color: kDefualtColor),),
    );
  }

}
