import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/signup/components/phone_body.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_simple_appbar.dart';

class SignUpPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('', context),
      body: Body()
    );
  }
}
