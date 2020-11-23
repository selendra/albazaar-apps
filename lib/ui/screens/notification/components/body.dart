import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatelessWidget {
  final List<NotificationModel> _notification;
  Body(this._notification);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _notification.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(_notification[index].img),
              ),
              title: Text(
                _notification[index].title,
                style: TextStyle(fontSize: 14.0),
              ),
              subtitle: Text(
                _notification[index].time,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
