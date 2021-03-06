import 'package:flutter/material.dart';
import 'package:albazaar_app/core/components/scaffold.dart';
import 'user_info_body.dart';

class UserInfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MyBodyScaffold(
      height: MediaQuery.of(context).size.height,
      child: Body(),
    );
  }
}