import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/detail/components/body.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/detail/components/detail_desktop.dart';
import 'components/bottom_navigation_detail.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductsProvider>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
      ),
      body: Responsive(
        desktop: ReuseDesktop(
          widget: DetailDesktop(),
        ),
        mobile: Body(),
      ),
      bottomNavigationBar: BottomNavigationDetail(loadedProduct),
    );
  }
}
