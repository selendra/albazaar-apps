import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/addlisting/components/body.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class AddListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizeService.of(context).translate('add_listing'),
          style: TextStyle(
            color: kDefaultColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDefaultColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Body(),
    );
  }
}
