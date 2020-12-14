import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseFlexSpace extends StatelessWidget {
  final String amount;
  ReuseFlexSpace(this.amount);
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        color: kDefaultColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text(
              'TOTAL BALANCE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  amount,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
