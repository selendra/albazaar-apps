import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseIndicator extends StatelessWidget {
  final int currentIndex;
  ReuseIndicator(this.currentIndex);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            3,
            (int index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 10.0,
                width: index == currentIndex ? 30.0 : 10.0,
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: index == currentIndex
                      ? kDefaultColor
                      : kDefaultColor.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
