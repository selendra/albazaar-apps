import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/app_services.dart';

class BtnSocial extends StatelessWidget {
  final Function onTap;
  final String logo;

  const BtnSocial(this.onTap, this.logo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 50.0,
          width: 50.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            border: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(logo),
        ));
  }
}
