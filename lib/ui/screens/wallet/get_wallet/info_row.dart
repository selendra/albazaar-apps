import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class InfoRow extends StatelessWidget {
  final String _seedText;
  final Function onPressed;

  InfoRow(
    this._seedText,
    this.onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return _infoRow(_seedText, onPressed);
  }

  Widget _infoRow(String _seedText, Function onPressed) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              _seedText,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: onPressed,
            child: Icon(
              Icons.content_copy,
              color: kDefaultColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
