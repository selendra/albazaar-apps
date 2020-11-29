import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/ui/component.dart';
import 'package:selendra_marketplace_app/ui/screens/tracking/tracking.dart';

class OrderDetailBody extends StatelessWidget {
  final OrderProduct productOrder;

  String address = """Smiles Devis\n123 Somewhere St\nSomewhere, USA 65060
  """;

  OrderDetailBody({this.productOrder});

  @override
  Widget build(BuildContext context) {
    // var _lang = AppLocalizeService.of(context);
    var sellerProvider = Provider.of<SellerProvider>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: SvgPicture.asset(
              "images/packaging.svg",
              width: 100,
              height: 100,
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reuseText("SUMMARY:\n", fontSize: 15),
                      Row(
                        children: [
                          Expanded(
                            child: reuseText("Order Id:"),
                          ),
                          Expanded(
                            child: reuseText('productOrder.id'),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: reuseText("Order Date: "),
                          ),
                          Expanded(
                            child: reuseText("Apr 3, 2017"),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: reuseText("Order Total: "),
                          ),
                          Expanded(
                            child: reuseText('{productOrder.price}៛'),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 5.0,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: reuseText("Seller name: "),
                      //     ),
                      //     Expanded(
                      //       child: reuseText('{productOrder.seller.value}'),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: reuseText("Seller phonenumber: "),
                      //     ),
                      //     Expanded(
                      //       child:
                      //           reuseText('{productOrder.sellerPhonenumber}'),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reuseText("SHIPPING ADDRESS:\n", fontSize: 15),
                      reuseText('productOrder.shippingAddress'),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context, RouteAnimation(enterPage: Tracking()));
                  },
                  child: Text(
                    'Track Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: kDefaultColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        kDefaultRadius,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reuseText(
                        'Seller: {productOrder.seller.value}',
                        fontSize: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          ReuseAlertDialog().successDialog(
                            context,
                            "Seller phone number: {productOrder.sellerPhonenumber}",
                          );
                        },
                        child: Text(
                          'Contact Seller',
                          style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('{productOrder.price}៛'),
                  subtitle: Text(
                    'productOrder.shippingAddress',
                    maxLines: 1,
                  ),
                  trailing: Text('productOrder.qauantity.toString()'),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage('productOrder.thumbnail'),
                  ),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         OrderDetailBody(productOrder: productOrder)));
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(20),
            child: ReuseButton.getItem(
                'Recieved',
                sellerProvider.isPayment && sellerProvider.isShipment
                    ? () async {
                        await Components.dialog(
                            context,
                            Text("Do you want to complete order?"),
                            Text("Message"),
                            action: FlatButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  // Provider.of<ProductsProvider>(context, listen: false)
                                  //     .markOrderComplete(productOrder.id, context,productOrder);
                                  print("Yes");

                                  await StorageServices.setData(
                                      {"goods_complete": true},
                                      'goods_confirm');
                                },
                                child: Text("Yes")));
                        // validateAndSubmit();
                      }
                    : null,
                context),
          ),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          //   child: ReuseButton.getItem('Confirm Shipping', () async {
          //     await Components.dialog(
          //         context,
          //         Text("Did you already check customer's shipping?"),
          //         Text("Massage"),
          //         action: FlatButton(
          //             onPressed: () {
          //               print("Yes");
          //             },
          //             child: Text("Yes")));
          //   }, context),
          // ),
        ],
      ),
    );
  }

  Widget reuseText(String text, {double fontSize: 13}) {
    return Text(text, style: TextStyle(fontSize: fontSize));
  }
}
