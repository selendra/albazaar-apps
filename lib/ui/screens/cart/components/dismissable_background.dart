import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class DimissibleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            AppLocalizeService.of(context).translate('remove'),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
