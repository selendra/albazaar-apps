import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/app_services.dart';

class ReuseFlatButton {
  static getItem(String text1, String text2, Function onPressed) {
    return Container(
      child: FlatButton(
        onPressed: onPressed,
        child: RichText(
          text: TextSpan(
            text: text1,
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: <TextSpan>[
              TextSpan(
                text: text2,
                style: TextStyle(
                  color: AppServices.hexaCodeToColor(AppColors.primary),
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
