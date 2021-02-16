import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/signup/components/body.dart';
import 'package:selendra_marketplace_app/core/components/scaffold.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyBodyScaffold(
      padding: const EdgeInsets.fromLTRB(35, 35, 35, 35),
      height: MediaQuery.of(context).size.height,
      scroll: BouncingScrollPhysics(),
      child: Expanded(
        child: Body()
      )
    );
  }
}
