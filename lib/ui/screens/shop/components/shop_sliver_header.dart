import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/shop/components/all_product_owner.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_header.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_tabbar.dart';

class ShopSliverHeader{

  final double cPadding = 10;
  final double padding = 16;
  
  List<Widget> sliverHeader({
    bool enableDelete,
    ShopProvider shopProvider,
    ProductsProvider productProvider,
    BuildContext context,
    TabController tabController,
    Function onTapTab,
    Function refresh,
    Function uploadRemainUrlImage,
    Function deleteProduct,
    Function onChanged,
  }){
    return [
      // Header
      SliverPersistentHeader(
        pinned: false,
        delegate: MySliverAppBarDelegate(
          minHeight: 400,
          maxHeight: 400,
          child: ShopHeader()
        )
      ),

      // Location
      SliverPersistentHeader(
        pinned: false,
        delegate: MySliverAppBarDelegate(
          minHeight: 50.0,
          maxHeight: 50.0,
          child: GestureDetector(
            onTap: () async{
              Components.dialogLoading(context: context);
              // await Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProduct()));
            },
            child: MyPadding(
              pBottom: pd10, pRight: pd10+2, pLeft: pd10+2, pTop: pd10,
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
                  MyText(left: pd10, text: "Set Address", fontWeight: FontWeight.w600, color: AppColors.secondary,),
                ],
              ),
            ),
          ),
        ),
      ),

      SliverPersistentHeader(
        pinned: false,
        delegate: MySliverAppBarDelegate(
          minHeight: 150,
          maxHeight: 150,
          child: MyPadding(
            pLeft: pd10+2, pRight: pd10+2,
            pBottom: pd20,
            child: MyCard(
              boxShadow: [
                boxShadow()
              ],
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/map.png'
                )
              ),
            )
          ),
      //     minHeight: 50,
      //     maxHeight: 50,
      //     child: Container(
      //       color: AppServices.hexaCodeToColor(AppColors.bgColor),
      //       child: MyPadding(
      //         pLeft: padding, pRight: padding,
      //         child: Align(
      //           alignment: Alignment.topLeft,
      //           child: MyText(
      //             text: "All Products",
      //             fontWeight: FontWeight.w600,
      //             fontSize: 20.0,
      //           )
      //         )
      //       )
      //     )
        ),
      ),

      // Button
      SliverPersistentHeader(
        pinned: true,
        delegate: MySliverAppBarDelegate(
          minHeight: 90,
          maxHeight: 90,
          child: Container(
            color: AppServices.hexaCodeToColor(AppColors.bgColor),
            child: ShopTabbar()
          ),
        )
      ),
      
      // Button
      SliverPersistentHeader(
        pinned: true,
        delegate: MySliverAppBarDelegate(
          minHeight: MediaQuery.of(context).size.height,
          maxHeight: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(child: AllProductOwner(enableDelete: enableDelete, productProvider: productProvider, listProductOwner: shopProvider.allOwnerProduct, uploadRemainUrlImage: uploadRemainUrlImage, deleteProduct: deleteProduct, onChanged: onChanged,)),
              // For Empty Size From Bottom
              SizedBox(
                height: 185,
                child: Container(),
              )
            ]
          )
        )
      )
    ];
  }
}