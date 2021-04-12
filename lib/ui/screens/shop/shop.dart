import 'package:albazaar_app/core/models/shop_m.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop_body.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/shop/components/body.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  
  ShopModel _shopModel = ShopModel();

  // void submit(){
  //   setState(() {
  //     _shopModel.shopCreate = 'created';
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _shopModel.init();
    _shopModel.controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _shopModel.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseAppBar.getTitle(
        _lang.translate('listing'),
        context,
        _lang.translate('all_seller'),
        _lang.translate('pending'),
        _lang.translate('complete'),
        _shopModel.controller
      ), //lang.translate('Products')x
      body: BodyScaffold(
        height: _shopModel.shopCreate == 'creating' ? MediaQuery.of(context).size.height : null,
        child: _shopModel.shopCreate == 'created' ? Body(_shopModel.controller) : 
        _shopModel.shopCreate == 'creating' ? CreateShop(shopModel: _shopModel) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/create_shop.svg', width: 293, height: 293),

              MyFlatButton(
                edgeMargin: EdgeInsets.only(left: 110, right: 110),
                height: 70,
                border: Border.all(color: AppServices.hexaCodeToColor(AppColors.primary), width: 2),
                isTransparent: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.primary)),
                    MyText(left: pd10, text: "Create Shop", fontWeight: FontWeight.w600, color: AppColors.primary,),
                  ],
                ),
                action: (){
                  setState(() {
                    _shopModel.shopCreate = 'creating';
                  });
                },
              )
            ],
          )
        )
      ),
    );
  }
}
