import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ExpandableContent extends StatelessWidget {
  final String locate;

  ExpandableContent(this.locate);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kDefaultRadius)),
                  elevation: 2,
                  child: ReuseInkwell.getItem(
                      locate ?? 'Location', Icons.location_on, () {}),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
