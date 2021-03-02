import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/components/scaffold.dart';
import 'package:selendra_marketplace_app/ui/screens/signin/components/body.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: MyBodyScaffold(
        // padding: const EdgeInsets.fromLTRB(35, 35, 35, 35),
        height: MediaQuery.of(context).size.height,
        scroll: BouncingScrollPhysics(),
        child: Column(
          children: [
            Expanded(
              child: Body()
            )
          ],
        )
      )
    );
  }
}
