import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/seller_m.dart';

class RowOfProduct extends StatelessWidget{

  final SellerModel sellerModel;

  final OrderProduct orderProduct;

  final bool seller;

  final Function onTap;

  RowOfProduct({
    this.sellerModel,
    this.orderProduct,
    this.seller = true,
    this.onTap
  });
  
  Widget build(BuildContext context){
    return InkWell(
      onTap: onTap,
      // () {
      //   // Navigator.of(context).push(
      //   //   RouteAnimation(
      //   //     enterPage: OrderDetail(
      //   //       productOrder: seller ? sellerModel, : orderProduct.
      //   //     ),
      //   //   ), //productsProvider.orItems[index]))
      //   // );
      // },
      child: Card(
        elevation: 0,
        shape: kDefaultShape,
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10.0),
          child: Row(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(kDefaultRadius),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        spreadRadius: 5.0,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: seller ? sellerModel.thumbnail : orderProduct.thumbnail,
                    fit: BoxFit.cover
                  ),
                ),
              ),

              MyPadding(
                pLeft: 12, pRight: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          MyText(
                            text: "Name:",
                            bottom: 10,
                          ),

                          MyText(
                            left: 6,
                            text: "${seller ? sellerModel.name : orderProduct.name}",
                            bottom: 10,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      )
                    ),
                    
                    Flexible(
                      child: Row(
                        children: [
                          MyText(
                            text: "Qty:",
                            bottom: 10,
                          ),

                          MyText(
                            left: 6,
                            text: "${seller ? sellerModel.qauantity : orderProduct.qauantity}",
                            bottom: 10,
                          )
                        ],
                      )
                    ),

                    Flexible(
                      child: Row(
                        children: [
                          MyText(
                            text: "Price:",
                            bottom: 10,
                          ),

                          MyText(
                            left: 6,
                            text: "${seller ? sellerModel.price : orderProduct.price}",
                            bottom: 10,
                          )
                        ],
                      )
                    ),

                    Flexible(
                      child: Row(
                        children: [
                          MyText(
                            text: "Status:",
                            bottom: 10,
                          ),

                          MyText(
                            left: 6,
                            text: "${seller ? sellerModel.orderStatus : orderProduct.orderStatus}",
                            color: AppColors.secondary,
                            bottom: 10,
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),

              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 12, right: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward_ios_outlined, size: 16, color: AppServices.hexaCodeToColor(AppColors.primary),)
                  )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}