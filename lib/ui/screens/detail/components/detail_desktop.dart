import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class DetailDesktop extends StatefulWidget {
  @override
  _DetailDesktopState createState() => _DetailDesktopState();
}

class _DetailDesktopState extends State<DetailDesktop> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Container(
            width: 800,
            child: Row(
              children: [
                Container(
                  width: 500,
                  color: Colors.red,
                ),
                Container(
                  width: 300,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(),
          )
        ],
      )),
    );
  }
}
