import 'package:flutter/material.dart';

class ReuseInkwell {
  static getItem(String title, Function onTap, { dynamic icon}) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey,
      child: ListTile(
        title: Text(title),
        leading: icon,
        dense: true,
      ),
    );
  }
}
