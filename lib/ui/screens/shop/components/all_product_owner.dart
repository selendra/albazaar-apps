import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/rate_product_c.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product.dart';

class AllProductOwner extends StatelessWidget{

  final List<OwnerProduct> listProduct;

  AllProductOwner({this.listProduct});

  Widget build(BuildContext context){
    return Container(
      height: 200,
      constraints: BoxConstraints(
        minHeight: 230,
        maxHeight: 300
      ),
      child: ListView.builder(
        itemCount: 1,//listProduct.length,
        itemBuilder: (context, int index){
          return Container(
            height: 180,
            padding: EdgeInsets.only(left: pd10+2, right: pd10+2, bottom: pd10+2),
            child: MyCard(
              boxShadow: [
                boxShadow()
              ],
              child: Row(
                children: [

                  MyCard(
                    hexaColor: AppColors.secondary,
                    height: double.infinity,
                    width: 146,
                    bTopRight: 0, bBottomRight: 0,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(listProduct[index].thumbnail)
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
                                  text: "${listProduct[index].name}",
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,
                                  color: "#000000",
                                )
                              ),
                              Expanded(flex: 0, child: Container()),
                              GestureDetector(
                                onTapDown: (TapDownDetails detail) async {
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
                                    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct() ));
                                  }
                                  else  if (result == "delete"){
                                    await Components.dialog(
                                      context, 
                                      MyText(text: "Are you sure to delete item?", pLeft: pd10, pRight: pd10,), 
                                      null, action: 
                                      TextButton(
                                        onPressed: (){}, 
                                        child: Text("Yes")
                                      )
                                    );
                                  }

                                },
                                onTap: () async {
                                },
                                child: SvgPicture.asset('assets/icons/edit.svg', width: 23, height: 23),
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
                            text: "${listProduct[index].description}",
                            fontSize: 12,
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
                              Image.asset('assets/symbols/riel_symbol.png', width: 9, height: 15),
                              MyText(
                                left: 6,
                                textAlign: TextAlign.left,
                                text: "${listProduct[index].price} /Kg",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              )
                            ],
                          )
                        ),

                        // RateProduct()
                        
                      ],
                    ),
                  )
                ],
              )
            )
          );
        }
      )
    );
  }
}