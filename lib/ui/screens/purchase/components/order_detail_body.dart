import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/component.dart';
import 'package:selendra_marketplace_app/ui/screens/tracking/tracking.dart';

class OrderDetailBody extends StatelessWidget {
  final OrderProduct productOrder;

  OrderDetailBody({this.productOrder});

  @override
  Widget build(BuildContext context) {
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
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reuseText("SUMMARY:\n", fontSize: 15),
                      Row(
                        children: [
                          Expanded(
                            child: reuseText("Seller Name:"),
                          ),
                          Expanded(
                            child: reuseText('${productOrder.seller.value}'),
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
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reuseText("SHIPPING ADDRESS:\n", fontSize: 15),
                      reuseText(productOrder.shippingAddress),
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
          ListTile(
            title: Text('${productOrder.price}៛'),
            subtitle: Text(
              productOrder.shippingAddress,
              maxLines: 1,
            ),
            trailing: Text(productOrder.qauantity.toString()),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(productOrder.thumbnail),
            ),
            onTap: () {},
          ),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(20),
            child: ReuseButton.getItem('Recieved', () async {
              await Components.dialog(context,
                  Text("Do you want to complete order?"), Text("Message"),
                  action: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Provider.of<ProductsProvider>(context, listen: false)
                            .markOrderComplete(
                                productOrder.id, context, productOrder);
                        print("Yes");
                      },
                      child: Text("Yes")));
              // validateAndSubmit();
            }, context),
          ),
        ],
      ),
    );
  }

  Widget reuseText(String text, {double fontSize: 13}) {
    return Text(text, style: TextStyle(fontSize: fontSize));
  }
}
