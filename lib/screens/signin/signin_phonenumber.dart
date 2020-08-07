import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_simple_appbar.dart';
import 'package:selendra_marketplace_app/screens/signin/components/phone_body.dart';

class SignInPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('', context),
      body: Body()
    );
  }
}
