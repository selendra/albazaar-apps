import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class IndividualChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Hello',
          style: titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: kDefaultColor,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/avatar.png'),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
