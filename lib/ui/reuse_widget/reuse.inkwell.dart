import 'package:flutter/material.dart';

class ReuseInkwell {
  static getItem(String title, IconData icon, Function onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey,
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        dense: true,
      ),
    );
  }
}
