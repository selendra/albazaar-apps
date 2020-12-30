import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/my_wallet/wallet_list.dart';

class WalletDesktop extends StatefulWidget {
  @override
  _WalletDesktopState createState() => _WalletDesktopState();
}

class _WalletDesktopState extends State<WalletDesktop> {
  GetRequest _getRequest = GetRequest();
  void fetchHistory() async {
    await _getRequest.getTrxHistory();
  }

  @override
  void initState() {
    fetchHistory();
    super.initState();
  }

  void resetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var history = Provider.of<TrxHistoryProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return _walletDesktop(
      history.trxHistoryList,
      userProvider.mUser.wallet,
      mBalance.data.balance,
      context,
    );
  }
}

List<String> itemsList = ['SEL'];

void _copyWallet(String _wallet) {
  Clipboard.setData(
    ClipboardData(
      text: _wallet,
    ),
  );
}

Widget _walletDesktop(
    List<TrxHistoryModel> history, String userWallet, String balance, context) {
  return ReuseDesktop(
    widget: Container(
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
                    decoration: BoxDecoration(
                      color: kDefaultColor,
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL BALANCE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              '$balance',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: wallets.length,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  width: 280,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(kDefaultRadius),
                                  ),
                                  child: ListTile(
                                    trailing: Text(
                                      wallets[index].amount,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    leading: Image.asset(wallets[index].logo,
                                        width: 30, height: 30),
                                    title: Text(
                                      wallets[index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).showCursorOnHover.hoverAnimation,
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
                                    fontSize: 20, fontWeight: FontWeight.w700),
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
                                    _copyWallet(value.mUser.wallet);
                                    // Scaffold.of(context).showSnackBar(SnackBar(
                                    //   content: Text('Copied'),
                                    //   duration: Duration(milliseconds: 500),
                                    // ));
                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(SnackBar(
                                    //   content: Text('Copied'),
                                    //   duration: Duration(milliseconds: 500),
                                    // ));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                  ).showCursorOnHover.hoverAnimation,
                ),
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
                                            trailing:
                                                AppUtils.timeStampToDateTime(
                                                    history[i].createdAt),
                                          ),
                                          ItemList(
                                              title: "Sender",
                                              trailing: history[i].sender),
                                          ItemList(
                                              title: "Destination",
                                              trailing: history[i].destination),
                                          ItemList(
                                              title: "Amount",
                                              trailing:
                                                  history[i].amount.toString()),
                                          ItemList(
                                              title: "Fee",
                                              trailing:
                                                  history[i].fee.toString()),
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
                                            style: TextStyle(fontSize: 10.0),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          userWallet == history[i].destination
                                              ? Text(
                                                  '+ ${history[i].amount} SEL',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.green,
                                                    fontSize: 18.0,
                                                  ),
                                                )
                                              : Text(
                                                  '- ${history[i].amount} SEL',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w900,
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
              ).showCursorOnHover.hoverAnimation,
            ),
          ),
        ],
      ),
    ),
  );
}
