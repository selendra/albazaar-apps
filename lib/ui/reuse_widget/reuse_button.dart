import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ReuseButton {
  static getItem(
    String text, 
    Function onTap, 
    BuildContext context,
    {
      double height = 60,
      double width,
    }
  ) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
          // padding: MaterialStateProperty
          // .all(
          //   EdgeInsets.only(bottom: 16, top: 16, right: 20, left: 20),
          // ),
          backgroundColor: MaterialStateProperty.all(AppServices.hexaCodeToColor(AppColors.primary)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))
            ),
          )
        )
      )
    );
  }
}
