import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/seller_m.dart';
import 'package:albazaar_app/core/providers/seller_provider.dart';
import 'package:albazaar_app/ui/screens/tracking/tracking.dart';

import '../../component.dart';

class SellerConfirmBody extends StatelessWidget {

  final SellerModel productOrder;

  PostRequest _postRequest = PostRequest();

  SellerConfirmBody({this.productOrder});

  @override
  Widget build(BuildContext context) {

    var _lang = AppLocalizeService.of(context);

    var sellerProvider = Provider.of<SellerProvider>(context, listen: false);

    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(AppLocalizeService.of(context).translate('payment_n_shipment'), context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: SvgPicture.asset("assets/packaging.svg", width: 150, height: 150),
          ),

          Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        reuseText("SUMMARY:\n", fontSize: 17, fontWeight: FontWeight.bold),

                        Row(
                          children: [
                            Expanded(
                              child: reuseText("Customer Name: "),
                            ),
                            Expanded(
                              child: reuseText("${productOrder.value}"),
                            )
                          ],
                        ),

                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: reuseText("Phone: "),
                            ),
                            Expanded(
                              child: reuseText("${productOrder.buyerPhonenumber}"),
                            )
                          ],
                        ),

                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: reuseText("Order Total: "),
                            ),
                            Expanded(
                              child: reuseText("${productOrder.total}៛"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Divider(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reuseText("SHIPPING ADDRESS:\n", fontSize: 17, fontWeight: FontWeight.bold),
                        reuseText("${productOrder.shippingAddress}")
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
                        imageUrl:  productOrder.thumbnail,
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
                          child: Icon(Icons.arrow_forward_ios_outlined, size: 16, color: AppServices.hexaCodeToColor(AppColors.primary)),
                        )
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        RouteAnimation(
                          enterPage: Tracking(
                            productOrder: SellerModel().sellerToOrder(productOrder),
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
          
          productOrder.orderStatus == "Order Complete" 
          ? Container()
          : Container(
            // margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            margin: const EdgeInsets.all(20),
            child: productOrder.orderStatus == 'Place Order'
            ? ReuseButton.getItem(
              _lang.translate('confirm_payment'),
              () async {
                await Components.dialog(
                  context,
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Do you want to confirm payment?', textAlign: TextAlign.center),
                  ),
                  null,
                  action: TextButton(
                    child: Text("Confirm"),
                    onPressed: () async {
                      Navigator.pop(context);
                      await _postRequest.markPamyment(productOrder.id).then((value) async {
                        var data = json.decode(value.body);
                        if (data['message'] != null) {
                          sellerProvider.fetchBuyerOrder();
                        }
                        await Components.dialog(
                          context,
                          Text(
                            data['message'] == null ? "${data['error']['message']}" : "${data['message']}",
                            textAlign: TextAlign.center,
                          ),
                          Text("Message")
                        );
                      });
                    },
                  ),
                );
              }, context
            )
            : ReuseButton.getItem(
              _lang.translate('confirm_shipping'),
              productOrder.orderStatus == 'Shipment' || productOrder.orderStatus == 'Order Complete'
              ? () async {
                if (productOrder.orderStatus == "Shipment"){
                  await Components.dialog(context, Text("Product is shipping\nwaiting confirm from customer", textAlign: TextAlign.center), Text("Message"));
                }
              }
              : () async {
                await Components.dialog(
                  context,
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Do you want to confirm shipment?', textAlign: TextAlign.center),
                  ),
                  null,
                  action: TextButton(
                    child: Text("Confirm"),
                    onPressed: () async {

                      Navigator.pop(context); // value.setShipment(productOrder.orderStatus);

                      await _postRequest.markShipment(productOrder.id).then(
                        (value) async {
                          var data = json.decode(value.body);
                          if (data['message'] != null) {
                            sellerProvider.fetchBuyerOrder();
                          }
                          await Components.dialog(
                            context,
                            Text(
                              data['message'] == null ? "${data['error']['message']}" : "${data['message']}",
                              textAlign: TextAlign.center
                            ),
                            Text("Message")
                          );
                        },
                      );
                    }, 
                  ),
                );
              },
              context
            ),
          ),
        ],
      )
    );
    // return ChangeNotifierProvider<SellerModel>.value(
    //   value: ModalRoute.of(context).settings.arguments as SellerModel,
    //   child: Consumer(
    //     builder: (context, value, child) {
    //       return SingleChildScrollView(
    //         child: ,
    //       );
    //     },
    //   ),
    // );
  }

  Widget reuseText(String text,{double fontSize: 13, FontWeight fontWeight, TextAlign textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
