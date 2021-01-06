import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_desktop.dart';
import 'user_info_body.dart';

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: ReuseDesktop(
          widget: Body(),
        ),
        mobile: Body(),
      ),
    );
  }
}
