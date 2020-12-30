import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import '../../component.dart';

class SellerConfirmBody extends StatelessWidget {
  final SellerModel productOrder;

  PostRequest _postRequest = PostRequest();

  SellerConfirmBody({this.productOrder});

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    var sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    return ChangeNotifierProvider<SellerModel>.value(
      value: ModalRoute.of(context).settings.arguments as SellerModel,
      child: Consumer(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset("images/packaging.svg",
                      width: 150, height: 150),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reuseText("SUMMARY:\n",
                                fontSize: 17, fontWeight: FontWeight.bold),
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
                                  child: reuseText(
                                      "${productOrder.buyerPhonenumber}"),
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
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reuseText("SHIPPING ADDRESS:\n",
                                fontSize: 17, fontWeight: FontWeight.bold),
                            reuseText("${productOrder.shippingAddress}")
                          ],
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
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: productOrder.orderStatus == 'Place Order'
                      ? ReuseButton.getItem(_lang.translate('confirm_payment'),
                          () async {
                          await ReuseAlertDialog().customDialog(
                            context,
                            'Do you want to confirm payment?',
                            () async {
                              Navigator.pop(context);
                              await _postRequest
                                  .markPamyment(productOrder.id)
                                  .then(
                                (value) async {
                                  var data = json.decode(value.body);
                                  if (data['message'] != null) {
                                    sellerProvider.fetchBuyerOrder();
                                  }
                                  await Components.dialog(
                                      context,
                                      Text(
                                        data['message'] == null
                                            ? "${data['error']['message']}"
                                            : "${data['message']}",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text("Message"));
                                },
                              );
                            },
                          );
                        }, context)
                      : ReuseButton.getItem(
                          _lang.translate('confirm_shipping'),
                          productOrder.orderStatus == 'Shipment' ||
                                  productOrder.orderStatus == 'Order Complete'
                              ? null
                              : () async {
                                  await ReuseAlertDialog().customDialog(
                                    context,
                                    'Do you want to confirm shipment?',
                                    () async {
                                      Navigator.pop(
                                          context); // value.setShipment(productOrder.orderStatus);
                                      await _postRequest
                                          .markShipment(productOrder.id)
                                          .then(
                                        (value) async {
                                          var data = json.decode(value.body);
                                          if (data['message'] != null) {
                                            sellerProvider.fetchBuyerOrder();
                                          }
                                          await Components.dialog(
                                              context,
                                              Text(
                                                  data['message'] == null
                                                      ? "${data['error']['message']}"
                                                      : "${data['message']}",
                                                  textAlign: TextAlign.center),
                                              Text("Message"));
                                        },
                                      );
                                    },
                                  );
                                },
                          context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget reuseText(String text,
      {double fontSize: 13, FontWeight fontWeight, TextAlign textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
