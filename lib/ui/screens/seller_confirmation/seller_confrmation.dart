import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_tracking.dart';

class SellerConfirm extends StatelessWidget {
  PostRequest _postRequest = PostRequest();

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    var loadedProduct =
        Provider.of<SellerProvider>(context).findById(productId);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('payment_n_shipment'),
          context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: SvgPicture.asset("images/packaging.svg",
                  width: 150, height: 150),
            ),
            Card(
              margin: const EdgeInsets.all(10),
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
                              child: reuseText("${loadedProduct.value}"),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: reuseText("Phone: "),
                            ),
                            Expanded(
                              child: reuseText(
                                  "${loadedProduct.buyerPhonenumber}"),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: reuseText("Order Total: "),
                            ),
                            Expanded(
                              child: reuseText("${loadedProduct.total}៛"),
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
                        reuseText("${loadedProduct.shippingAddress}")
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteAnimation(
                          enterPage: SellerTracking(
                            sellerModel: loadedProduct,
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
                  )
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
                          loadedProduct.thumbnail,
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
                              loadedProduct.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            isThreeLine: true,
                            subtitle: Text(
                              'Qty: ${loadedProduct.qauantity}',
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
                              'Price: ${loadedProduct.price}៛ ',
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
            Consumer<SellerProvider>(
              builder: (context, value, child) {
                var item = value.findById(loadedProduct.id);
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: item.orderStatus == 'Place Order'
                      ? ReuseButton.getItem(_lang.translate('confirm_payment'),
                          () async {
                          await ReuseAlertDialog().customDialog(
                            context,
                            'Do you want to confirm payment?',
                            () async {
                              Navigator.pop(context);
                              await _postRequest
                                  .markPamyment(loadedProduct.id)
                                  .then(
                                (value) async {
                                  var data = json.decode(value.body);
                                  if (data['message'] != null) {
                                    //  sellerProvider.fetchBuyerOrder();
                                    await Provider.of<SellerProvider>(context,
                                            listen: false)
                                        .fetchBuyerOrder();
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
                          item.orderStatus == 'Shipment' ||
                                  item.orderStatus == 'Order Complete'
                              ? null
                              : () async {
                                  await ReuseAlertDialog().customDialog(
                                    context,
                                    'Do you want to confirm shipment?',
                                    () async {
                                      Navigator.pop(
                                          context); // value.setShipment(productOrder.orderStatus);
                                      await _postRequest
                                          .markShipment(loadedProduct.id)
                                          .then(
                                        (value) async {
                                          var data = json.decode(value.body);
                                          if (data['message'] != null) {
                                            // sellerProvider.fetchBuyerOrder();
                                            await Provider.of<SellerProvider>(
                                                    context,
                                                    listen: false)
                                                .fetchBuyerOrder();
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
                          context,
                        ),
                );
              },
            ),
          ],
        ),
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
