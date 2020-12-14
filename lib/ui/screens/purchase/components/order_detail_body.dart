import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/component.dart';
import 'package:selendra_marketplace_app/ui/screens/tracking/tracking.dart';

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
              "images/confirm_product.svg",
              width: 150,
              height: 150,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reuseText(_lang.translate('summary') + ":\n",
                          fontSize: 15),
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
                            child:
                                reuseText(_lang.translate('phone_hint') + ":"),
                          ),
                          Expanded(
                            child:
                                reuseText("${productOrder.sellerPhonenumber}"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: reuseText(
                                _lang.translate('order_total') + ": "),
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
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reuseText(_lang.translate('shipping_address') + ":\n",
                          fontSize: 15),
                      reuseText('${productOrder.shippingAddress}'),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteAnimation(
                        enterPage: Tracking(
                          productOrder: productOrder,
                        ),
                      ),
                    );
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
                      child: Image.network(
                        productOrder.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: Text(
                            productOrder.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          isThreeLine: true,
                          subtitle: Text(
                            'Qty: ${productOrder.qauantity}',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          subtitle: Text(
                            'Price: ${productOrder.price}៛ ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kDefaultColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(20),
            child: ReuseButton.getItem(
                'Recieved',
                productOrder.orderStatus == 'Place Order' ||
                        productOrder.orderStatus == 'Order Complete'
                    ? null
                    : () async {
                        await Components.dialog(
                          context,
                          Text("Do you want to complete order?"),
                          Text("Message"),
                          action: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<ProductsProvider>(context,
                                      listen: false)
                                  .markOrderComplete(
                                      productOrder.id, context, productOrder);
                            },
                            child: Text("Yes"),
                          ),
                        );
                      },
                context),
          ),
        ],
      ),
    );
  }

  Widget reuseText(String text, {double fontSize: 13}) {
    return Text(text, style: TextStyle(fontSize: fontSize));
  }
}
