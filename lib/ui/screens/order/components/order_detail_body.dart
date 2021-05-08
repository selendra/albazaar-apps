import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:albazaar_app/all_export.dart';

class OrderDetailBody extends StatelessWidget {
  final OrderProduct productOrder;

  OrderDetailBody({this.productOrder});

  @override
  Widget build(BuildContext context) {
    final _lang = AppLocalizeService.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              "assets/confirm_product.svg",
              width: 150,
              height: 150,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(12),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reuseText(_lang.translate('summary') + ":\n",fontSize: 15),
                        Row(
                          children: [
                            Expanded(
                              child:
                                  reuseText(_lang.translate('seller_name') + ":"),
                            ),
                            Expanded(
                              child: reuseText('${productOrder.seller.value}'),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: reuseText(_lang.translate('phone_hint') + ":"),
                            ),
                            Expanded(
                              child: reuseText("${productOrder.sellerPhonenumber}"),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: reuseText(_lang.translate('order_total') + ": "),
                            ),
                            Expanded(
                              child: reuseText('${productOrder.total}៛'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  Divider(),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reuseText(_lang.translate('shipping_address') + ":\n", fontSize: 15),
                        reuseText('${productOrder.shippingAddress}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10.0),
            shape: kDefaultShape,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10.0),
              child: Row(
                children: [

                  // Image Product
                  ClipRRect(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                    child: Container(
                      width: 100,
                      height: 100,
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
                        imageUrl: productOrder.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // User Data
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
                                text: "${productOrder.name}",
                                bottom: 10,
                              )
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
                                text: "${productOrder.qauantity}",
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
                                text: "${productOrder.price}",
                                bottom: 10,
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),

                  Expanded(child: Container(),),

                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Row(
                      children: [
                        Text(
                          "Track",
                          style: TextStyle(color: AppServices.hexaCodeToColor(AppColors.primary))
                        ),
                        Flexible(
                          child: Icon(Icons.arrow_forward_ios_outlined, size: 14, color: AppServices.hexaCodeToColor(AppColors.primary)),
                        )
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        RouteAnimation(
                          enterPage: Tracking(
                            productOrder: productOrder,
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(20),
            child: ReuseButton.getItem('Recieve',
              productOrder.orderStatus == 'Place Order' || productOrder.orderStatus == 'Order Complete'
              ? null : () async {
                await Components.dialog(
                  context,
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Do you want to complete order?", textAlign: TextAlign.center)
                  ),
                  Text("Message"),
                  action: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<ProductsProvider>(context, listen: false).markOrderComplete(productOrder.id, context, productOrder);
                    },
                    child: Text("Yes"),
                  ),
                );
              },
              context,
              width: MediaQuery.of(context).size.width
            ),
          ),
        ],
      ),
    );
  }

  Widget reuseText(String text, {double fontSize: 13}) {
    return Text(text, style: TextStyle(fontSize: fontSize));
  }
}
