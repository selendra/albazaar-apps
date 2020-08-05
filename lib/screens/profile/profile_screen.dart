import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/profile/components/body.dart';
import 'package:selendra_marketplace_app/constants.dart';


class ProfileScreen extends StatefulWidget {

  final String name, url, email;
  ProfileScreen(this.name,this.url,this.email);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: kDefualtColor,),onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: Body(),
    );
  }
}
