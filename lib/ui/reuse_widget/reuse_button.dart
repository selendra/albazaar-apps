import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ReuseButton {
  static getItem(
    String text, 
    Function onTap, 
    BuildContext context,
    {double height = 59}
  ) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
        backgroundColor: MaterialStateProperty.all(AppServices.hexaCodeToColor(AppColors.primary)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))
          ),
        )
      )
    );
  }
}
