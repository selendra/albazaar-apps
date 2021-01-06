import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/detail/components/body.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'components/bottom_navigation_detail.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductsProvider>(context).findById(productId);
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? ReuseSimpleAppBar.getItem('Detail', context)
          : null,
      body: Responsive(
        desktop: ReuseDesktop(
          widget: Body(),
        ),
        mobile: Body(),
      ),
      bottomNavigationBar: BottomNavigationDetail(loadedProduct),
    );
  }
}
