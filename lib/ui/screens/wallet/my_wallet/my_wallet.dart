import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/bottom_sheet_c.dart';
import 'package:selendra_marketplace_app/core/providers/trx_history_provider.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';
import 'wallet_list.dart';

class MyWallet extends StatefulWidget {
  final Function resetState;

  MyWallet({this.resetState});

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size.width * 0.15;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: RefreshIndicator(
        onRefresh: () async {
          // await Future.delayed(Duration(seconds: 0));
          await Provider.of<TrxHistoryProvider>(context, listen: false)
              .fetchTrxHistory();
          await Provider.of<UserProvider>(context, listen: false)
              .fetchPortforlio();
        },
        child: WalletMobile(
          resetState: widget.resetState,
        ),
      ),
    );
  }
}

List<String> itemsList = ['SEL'];

class WalletMobile extends StatelessWidget {
  final Function resetState;

  WalletMobile({this.resetState});

  void _copyWallet(String _wallet) {
    Clipboard.setData(
      ClipboardData(
        text: _wallet,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // /var _lang = AppLocalizeService.of(context);
    var history = Provider.of<TrxHistoryProvider>(context).trxHistoryList;
    final userWallet = Provider.of<UserProvider>(context).mUser.wallet;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Card(
            shape: kDefaultShape,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                color: kDefaultColor,
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL BALANCE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                          hoverColor: Colors.white.withOpacity(0.7),
                          onTap: () async {
                            await MyBottomSheet().trxOptions(
                                context: context,
                                portfolioList: [],
                                resetState: resetState);
                          },
                          child: Icon(Icons.send,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        '${mBalance.data.balance}',
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
                                style: TextStyle(fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: Image.asset(wallets[index].logo,
                                  width: 30, height: 30),
                              title: Text(
                                wallets[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
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
          const SizedBox(height: 10),
          Card(
            shape: kDefaultShape,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
              height: 300,
              width: MediaQuery.of(context).size.width,
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
                          embeddedImage: AssetImage('images/sld_qr.png'),
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
                          hoverColor: Colors.transparent,
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
                              children: [Icon(Icons.copy), Text('Copy')],
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
          const SizedBox(height: 10),
          Container(
            height: 600,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Card(
              shape: kDefaultShape,
              child: Container(
                width: MediaQuery.of(context).size.width,
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
        ],
      ),
    );
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   child: Stack(
    //     fit: StackFit.expand,
    //     children: <Widget>[
    //       Column(
    //         children: <Widget>[
    //           Container(
    //             height: MediaQuery.of(context).size.height * 0.3,
    //             width: MediaQuery.of(context).size.width,
    //             color: kDefaultColor,
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: <Widget>[
    //                 SizedBox(height: 40),
    //                 Text(
    //                   'TOTAL BALANCE',
    //                   style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 14.0,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //                 SizedBox(height: 40),
    //                 Flexible(
    //                   child: Container(
    //                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
    //                     child: Text(
    //                       '${mBalance.data.balance}',
    //                       overflow: TextOverflow.ellipsis,
    //                       softWrap: true,
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 45.0,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //       Container(
    //         padding: EdgeInsets.only(
    //             top: MediaQuery.of(context).size.height / 4,
    //             right: 10.0,
    //             left: 10.0),
    //         child: Container(
    //           child: Column(
    //             children: <Widget>[
    //               // List All Asset
    //               WalletList(),

    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Container(
    //                 margin: const EdgeInsets.all(16.0),
    //                 child: Column(
    //                   children: <Widget>[
    //                     SizedBox(
    //                       height: 20,
    //                     ),
    //                     Responsive(
    //                       mobile: ReuseButton.getItem(_lang.translate('send'),
    //                           () async {
    //                         await MyBottomSheet().trxOptions(
    //                             context: context,
    //                             portfolioList: [],
    //                             resetState: resetState);
    //                       }, context),
    //                       desktop: Container(
    //                         margin: const EdgeInsets.symmetric(
    //                           horizontal: 10.0,
    //                         ),
    //                         width: MediaQuery.of(context).size.width * 0.3,
    //                         child: ReuseButton.getItem(_lang.translate('send'),
    //                             () async {
    //                           await MyBottomSheet().trxOptions(
    //                               context: context,
    //                               portfolioList: [],
    //                               resetState: resetState);
    //                         }, context),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     Responsive(
    //                       mobile: ReuseButton.getItem(
    //                           _lang.translate('recieve'), () {
    //                         Navigator.pushNamed(context, MyQrView);
    //                       }, context),
    //                       desktop: Container(
    //                         margin: const EdgeInsets.symmetric(
    //                           horizontal: 10.0,
    //                         ),
    //                         width: MediaQuery.of(context).size.width * 0.3,
    //                         child: ReuseButton.getItem(
    //                             _lang.translate('recieve'), () {
    //                           Navigator.pushNamed(context, MyQrView);
    //                         }, context),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

// class WalletDesktop extends StatelessWidget {
//   final Function resetState;

//   WalletDesktop({this.resetState});

//   @override
//   Widget build(BuildContext context) {
//     var _lang = AppLocalizeService.of(context);
//     return Row(
//       children: [
//         Flexible(
//             flex: 2,
//             child: Container(
//               color: kDefaultColor,
//             )),
//         Container(
//           width: 800,
//           color: Colors.red,
//         ),
//         // Container(
//         //   width: 800,
//         //   height: MediaQuery.of(context).size.height,
//         //   child: Stack(
//         //     fit: StackFit.expand,
//         //     children: <Widget>[
//         //       Column(
//         //         children: <Widget>[
//         //           Container(
//         //             height: MediaQuery.of(context).size.height * 0.3,
//         //             width: MediaQuery.of(context).size.width,
//         //             color: kDefaultColor,
//         //             child: Column(
//         //               mainAxisSize: MainAxisSize.min,
//         //               children: <Widget>[
//         //                 SizedBox(height: 40),
//         //                 Text(
//         //                   'TOTAL BALANCE',
//         //                   style: TextStyle(
//         //                       color: Colors.white,
//         //                       fontSize: 14.0,
//         //                       fontWeight: FontWeight.bold),
//         //                 ),
//         //                 SizedBox(height: 40),
//         //                 Flexible(
//         //                   child: Container(
//         //                     padding:
//         //                         const EdgeInsets.symmetric(horizontal: 30.0),
//         //                     child: Text(
//         //                       '${mBalance.data.balance}',
//         //                       overflow: TextOverflow.ellipsis,
//         //                       softWrap: true,
//         //                       style: TextStyle(
//         //                           color: Colors.white,
//         //                           fontSize: 45.0,
//         //                           fontWeight: FontWeight.bold),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //           ),
//         //           Expanded(
//         //             child: Container(
//         //               color: Colors.white,
//         //             ),
//         //           ),
//         //         ],
//         //       ),
//         //       Container(
//         //         padding: EdgeInsets.only(
//         //             top: MediaQuery.of(context).size.height / 4,
//         //             right: 10.0,
//         //             left: 10.0),
//         //         child: Container(
//         //           child: Column(
//         //             children: <Widget>[
//         //               // List All Asset
//         //               WalletList(),

//         //               SizedBox(
//         //                 height: 10,
//         //               ),
//         //               Container(
//         //                 margin: const EdgeInsets.all(16.0),
//         //                 child: Column(
//         //                   children: <Widget>[
//         //                     SizedBox(
//         //                       height: 20,
//         //                     ),
//         //                     Responsive(
//         //                       mobile: ReuseButton.getItem(
//         //                           _lang.translate('send'), () async {
//         //                         await MyBottomSheet().trxOptions(
//         //                             context: context,
//         //                             portfolioList: [],
//         //                             resetState: resetState);
//         //                       }, context),
//         //                       desktop: Container(
//         //                         margin: const EdgeInsets.symmetric(
//         //                           horizontal: 10.0,
//         //                         ),
//         //                         width: MediaQuery.of(context).size.width * 0.3,
//         //                         child: ReuseButton.getItem(
//         //                             _lang.translate('send'), () async {
//         //                           await MyBottomSheet().trxOptions(
//         //                               context: context,
//         //                               portfolioList: [],
//         //                               resetState: resetState);
//         //                         }, context),
//         //                       ),
//         //                     ),
//         //                     SizedBox(
//         //                       height: 10,
//         //                     ),
//         //                     Responsive(
//         //                       mobile: ReuseButton.getItem(
//         //                           _lang.translate('recieve'), () {
//         //                         Navigator.pushNamed(context, MyQrView);
//         //                       }, context),
//         //                       desktop: Container(
//         //                         margin: const EdgeInsets.symmetric(
//         //                           horizontal: 10.0,
//         //                         ),
//         //                         width: MediaQuery.of(context).size.width * 0.3,
//         //                         child: ReuseButton.getItem(
//         //                             _lang.translate('recieve'), () {
//         //                           Navigator.pushNamed(context, MyQrView);
//         //                         }, context),
//         //                       ),
//         //                     ),
//         //                   ],
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         Flexible(
//             flex: 2,
//             child: Container(
//               color: Colors.red,
//             )),
//       ],
//     );
//   }

//   Widget wallet() {
//     return Column(
//       children: [
//         Container(
//           color: Colors.red,
//         )
//       ],
//     );
//   }
//}
