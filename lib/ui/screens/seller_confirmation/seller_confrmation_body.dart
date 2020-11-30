import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';
import 'package:selendra_marketplace_app/ui/component.dart';

class SellerConfirmBody extends StatelessWidget {
  final SellerModel productOrder;

  PostRequest _postRequest = PostRequest();

  String address = """Smiles Devis\n123 Somewhere St\nSomewhere, USA 65060
  """;

  SellerConfirmBody({this.productOrder});

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
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
                      Row(
                        children: [
                          Expanded(
                            child: reuseText("Phone: "),
                          ),
                          Expanded(
                            child:
                                reuseText("${productOrder.sellerPhonenumber}"),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: reuseText("Order Total: "),
                          ),
                          Expanded(
                            child: reuseText("SEL ${productOrder.total}"),
                          )
                        ],
                      )
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
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: reuseText("PRODUCT",
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                  child: reuseText("QTY",
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 70,
                  child: reuseText("PRICE",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Row(
                        children: [
                          Flexible(
                            child: Image.network(
                              "${productOrder.thumbnail}",
                              width: 80,
                              height: 80,
                            ),
                          ),
                          Expanded(
                            child: reuseText("""${productOrder.name}៛""",
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: reuseText("${productOrder.qauantity}",
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      width: 70,
                      child: reuseText("${productOrder.price}៛",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.right)),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: ReuseButton.getItem(_lang.translate('confirm_payment'),
                () async {
              var result = await Components.dialog(
                  context,
                  Text("Complete check payment?", textAlign: TextAlign.center),
                  Text("Massage"),
                  action: FlatButton(
                      onPressed: () async {
                        Navigator.pop(context, true);
                      },
                      child: Text("Yes")));

              if (result == true) {
                Components.dialogLoading(context: context);
                try {
                  await _postRequest
                      .markPamyment(productOrder.id)
                      .then((value) async {
                    var data = json.decode(value.body);
                    await Components.dialog(
                        context,
                        Text(
                          data['message'],
                          textAlign: TextAlign.center,
                        ),
                        Text("Message"));
                  });

                  //Close Dialog
                  Navigator.pop(context);
                } catch (e) {}
              }
            }, context),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ReuseButton.getItem(_lang.translate('confirm_shipping'),
                () async {
              var result = await Components.dialog(
                  context,
                  Text("Complete prepare for shipping?",
                      textAlign: TextAlign.center),
                  Text("Massage"),
                  action: FlatButton(
                      onPressed: () async {
                        Navigator.pop(context, true);
                      },
                      child: Text("Yes")));

              if (result == true) {
                Components.dialogLoading(context: context);
                try {
                  await _postRequest.markShipment(productOrder.id).then(
                    (value) async {
                      var data = json.decode(value.body);
                      await Components.dialog(
                          context,
                          Text(data['message'], textAlign: TextAlign.center),
                          Text("Message"));
                    },
                  );
                  //Close Dialog
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }
            }, context),
          ),
        ],
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
