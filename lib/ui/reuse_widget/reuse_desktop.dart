import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseDesktop extends StatelessWidget {
  final Widget widget;
  ReuseDesktop({@required this.widget});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 2, child: Container()),
        Container(
          width: 800,
          child: widget,
        ),
        Flexible(flex: 2, child: Container())
      ],
    );
  }
}
