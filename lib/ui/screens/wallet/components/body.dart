import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/my_wallet/wallet_list.dart';

import '../../../../all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GetRequest _getRequest = GetRequest();

  showAlertDialog(BuildContext context, String alertText) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        context = navigationKey.currentState.overlay.context;
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text('Oops!'),
      content: Text(alertText),
      actions: [
        okButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: navigationKey.currentState.overlay.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<String> itemsList = ['SEL'];

  onGetWallet() async {
    // String _token;
    // SharedPreferences isToken = await SharedPreferences.getInstance();
    // _token = isToken.get('token');
    // if (_token == null) {
    //   String alertText = 'Please Sign up with Email or Phone to get wallet';
    //   showAlertDialog(context, alertText);
    // } else {
    //   Navigator.pushNamed(context, WalletPinView);
    // }

    Navigator.pushNamed(context, WalletPinView);
  }

  void resetState() {
    setState(() {});
  }

  void fetchHistory() async {
    await _getRequest.getTrxHistory();
  }

  @override
  void initState() {
    fetchHistory();
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
  }

  @override
  Widget build(BuildContext context) {
    var history = Provider.of<TrxHistoryProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    mBalance.token = 'token';
    return Container();
    // WalletChoice(onGetWallet, showAlertDialog);
    // mBalance.token == null
    //     ? Center(
    //         child: WalletChoice(onGetWallet, showAlertDialog),
    //       )
    //     : MyWallet(resetState: resetState);
  }

  void copyWallet(String _wallet) {
    Clipboard.setData(
      ClipboardData(
        text: _wallet,
      ),
    );
  }

  Widget _wallet(List<TrxHistoryModel> history, String userWallet) {
    return Row(
      children: [
        Flexible(flex: 2, child: Container()),
        Container(
          width: 800,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                height: 300,
                child: Row(
                  children: [
                    Card(
                      shape: kDefaultShape,
                      child: Container(
                        width: 480,
                        height: 500,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Total balance",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "2000",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              //WalletList(),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Card(
                      shape: kDefaultShape,
                      child: Container(
                        height: 500,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wallet Information",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                ReuseDropDown(
                                  initialValue: 'SEL',
                                  itemsList: itemsList,
                                ),
                              ],
                            ),
                            Consumer<UserProvider>(
                              builder: (context, value, child) => Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  QrImage(
                                    data: value.mUser.wallet,
                                    version: QrVersions.auto,
                                    embeddedImage:
                                        AssetImage('images/sld_qr.png'),
                                    size: 150,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    value.mUser.wallet,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10.0),
                                  InkWell(
                                    onTap: () {
                                      copyWallet(value.mUser.wallet);
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Copied'),
                                        duration: Duration(milliseconds: 500),
                                      ));
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(SnackBar(
                                      //   content: Text('Copied'),
                                      //   duration: Duration(milliseconds: 500),
                                      // ));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.copy),
                                          Text('Copy')
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Container(
                                  //   height: 40,
                                  //   width: 150,
                                  //   child: ReuseButton.getItem('Copy', () {
                                  //     copyWallet(value.mUser.wallet);
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(SnackBar(
                                  //       content: Text('Copied'),
                                  //       duration: Duration(milliseconds: 300),
                                  //     ));
                                  //     // Scaffold.of(context).showSnackBar(
                                  //     //   SnackBar(
                                  //     //     content: Text("Copied"),
                                  //     //     duration: Duration(milliseconds: 300),
                                  //     //   ),
                                  //     // );
                                  //   }, context),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Card(
                    shape: kDefaultShape,
                    child: Container(
                      width: 800,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Transaction history",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                itemCount: history.length,
                                itemBuilder: (context, i) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await Components.dialog(
                                          context,
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ItemList(
                                                  title: "Id",
                                                  trailing: history[i].id),
                                              ItemList(
                                                title: "Created At",
                                                trailing: AppUtils
                                                    .timeStampToDateTime(
                                                        history[i].createdAt),
                                              ),
                                              ItemList(
                                                  title: "Sender",
                                                  trailing: history[i].sender),
                                              ItemList(
                                                  title: "Destination",
                                                  trailing:
                                                      history[i].destination),
                                              ItemList(
                                                  title: "Amount",
                                                  trailing: history[i]
                                                      .amount
                                                      .toString()),
                                              ItemList(
                                                  title: "Fee",
                                                  trailing: history[i]
                                                      .fee
                                                      .toString()),
                                              ItemList(
                                                  title: "Memo",
                                                  trailing: history[i].memo),
                                            ],
                                          ),
                                          Text(
                                            "Transaction history",
                                            textAlign: TextAlign.left,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        //margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                                        height: 60.0,
                                        color: Colors.white,
                                        child: ListTile(
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                AppUtils.timeStampToDateTime(
                                                    history[i].createdAt),
                                                style:
                                                    TextStyle(fontSize: 10.0),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              userWallet ==
                                                      history[i].destination
                                                  ? Text(
                                                      '+ ${history[i].amount} SEL',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.green,
                                                        fontSize: 18.0,
                                                      ),
                                                    )
                                                  : Text(
                                                      '- ${history[i].amount} SEL',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.red,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          leading: Image.asset(
                                              'images/icon_launcher.png',
                                              width: 30,
                                              height: 30),
                                          title: Text(
                                            userWallet == history[i].destination
                                                ? 'Recieved'
                                                : 'Sent',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 4.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(flex: 2, child: Container()),
      ],
    );
  }
}
