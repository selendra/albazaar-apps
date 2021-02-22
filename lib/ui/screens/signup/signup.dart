import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/signup/components/body.dart';
import 'package:selendra_marketplace_app/core/components/scaffold.dart';

class SignUp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: MyBodyScaffold(
        height: MediaQuery.of(context).size.height,
        scroll: BouncingScrollPhysics(),
        child: Body()
      )
    );
  }
}
