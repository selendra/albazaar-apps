import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/ui/screens/listing/components/body.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_appbar.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class ListingScreen extends StatefulWidget {
  @override
  _ListingScreenState createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen>with SingleTickerProviderStateMixin {

  TabController _controller;

  bool isSold = false;
  
  @override
  void initState() {
    getMarkFromBuyer();
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getMarkFromBuyer() async {
    await StorageServices.fetchData('goods_confirm').then((value) {
      if (value != null){
        isSold = value['goods_complete'];
      }
    });
    setState(() {
      print("Is sold $isSold");
    });
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizeService.of(context);
    final sellerProvider = Provider.of<SellerProvider>(context);
    print(sellerProvider.allBuyerOrder);
    return Scaffold(
      appBar: ReuseAppBar.getTitle(lang.translate('listing'), context,
          'Products', 'Pending', 'Sold', _controller), //lang.translate('Products')
      body: Body(_controller, sellerProvider: sellerProvider, isSold: isSold),
    );
  }
}
