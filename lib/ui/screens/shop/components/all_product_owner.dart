import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/rate_product_c.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/core/services/auth/find_service.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product.dart';

class AllProductOwner extends StatelessWidget{

  final bool enableDelete;

  final List<OwnerProduct> listProductOwner;

  final ProductsProvider productProvider;

  final Function uploadRemainUrlImage;

  final Function deleteProduct;

  final Function onChanged;

  AllProductOwner({this.enableDelete, this.productProvider, this.listProductOwner, this.uploadRemainUrlImage, this.deleteProduct, this.onChanged});

  Widget build(BuildContext context){
    print(productProvider.addProductProvider.addProduct.weightList.toString() +"weight");
    // final _listImages = Provider.of<ShopProvider>(context).listImages;
    print(enableDelete);

    return ListView.builder(
      itemCount: listProductOwner.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, int index){
        return Container(
          // height: 180,
          padding: EdgeInsets.only(left: pd10+2, right: pd10+2, bottom: pd10+2),
          child: MyCard(
            boxShadow: [
              boxShadow()
            ],
            child: Row(
              children: [

                MyCard(
                  hexaColor: AppColors.secondary,
                  height: 150,
                  width: 146,
                  bTopRight: 0, bBottomRight: 0,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(listProductOwner[index].thumbnail)
                  ),
                ),

                Flexible(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      MyPadding(
                        pLeft: pd10+5, pRight: pd10,
                        pBottom: pd10,
                        pTop: pd10,
                        child: Row(                    
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: MyText(
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                text: "${listProductOwner[index].name}",
                                fontSize:20,
                                fontWeight: FontWeight.bold,
                                color: "#000000",
                              )
                            ),
                            Expanded(flex: 0, child: Container()),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTapDown: (TapDownDetails detail) async {
                                  print("My category edit ${listProductOwner[index].categoryId}");
                                  // var x = getBox.localToGlobal(detail.globalPosition.dx);
                                  print(detail.globalPosition);
                                  // print("Box ${getBox.size}");
                                  final result = await Navigator.push(
                                    context, 
                                    popUpRoute(
                                      MyDropDownCustom.productEdit(context: context,x: detail.globalPosition.dx, y: detail.globalPosition.dy,), sigmaX: 0.0, sigmaY: 0.0
                                    )
                                  );
                                  print(result);
                                  if (result == 'edit'){
                                    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct(productOwner: listProductOwner[index], addProductProvider: productProvider.addProductProvider,))).then((value) async {
                                      if(value != null){
                                        await uploadRemainUrlImage(value['productModel'], value['productId']);
                                      }
                                    });
                                  }
                                  else if (result == "delete"){
                                    final result = await Components.dialog(
                                      context, 
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MyText(text: "Are you sure to delete item?", pLeft: pd10, pRight: pd10, pBottom: pd35,),
                                          // MyText(text: "Please fill out your product name", fontSize: 18, pLeft: pd10, pRight: pd10),
                                          // MyPadding(
                                          //   pLeft: pd10, pRight: pd10,
                                          //   child: TextFormField(
                                          //     controller: _controller,
                                          //     onChanged: (String value){
                                          //       onChanged(value, listProductOwner[index].name, context);
                                          //     },
                                          //   ),
                                          // )
                                        ],
                                      ), 
                                      Container(height: 20,), 
                                      action: TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context, 'yes');
                                        }, 
                                        child: Text("Yes", style: TextStyle(color: Colors.red ))
                                      )
                                    );

                                    if (result == 'yes'){
                                      await deleteProduct(listProductOwner[index].id);
                                    }
                                  }

                                },
                                onTap: () async {
                                },
                                child: SvgPicture.asset('assets/icons/edit.svg', width: 23, height: 23),
                              )
                            )
                          ],
                        )
                      ),

                      MyPadding(
                        pLeft: pd10+5, pRight: pd10+5,
                        pBottom: pd10,
                        child: MyText(
                          width: MediaQuery.of(context).size.width,
                          textAlign: TextAlign.left,
                          text: "${listProductOwner[index].description}",
                          fontSize: 16,
                          color: "#000000",
                          overflow: TextOverflow.ellipsis,
                          maxLine: 1,
                        )
                      ),

                      MyPadding(
                        pLeft: pd10+5, pRight: pd10+5,
                        pBottom: pd10,
                        child: Row(
                          children: [
                            SvgPicture.asset('${AppConfig.symbolPath}/riel.svg', width: 9, height: 15),
                            MyText(
                              left: 6,
                              textAlign: TextAlign.left,
                              text: "${listProductOwner[index].price} / ${FindingServices().findScaleById(listProductOwner[index].weight, Provider.of<AddProductProvider>(context, listen: false).addProduct.weightList)}",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            )
                          ],
                        )
                      ),

                      Container(
                        height: 30,
                        child: MyPadding(
                          pLeft: pd10+5, pRight: pd10+5,
                          pBottom: pd10,
                          child: RateProduct(),
                        )
                      )
                      
                    ],
                  ),
                )
              ],
            )
          )
        );
      }
    );
  }
}