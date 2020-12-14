import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/bottom_sheet_c.dart';
import 'package:selendra_marketplace_app/core/providers/trx_history_provider.dart';
import 'wallet_list.dart';

class MyWallet extends StatelessWidget {
  final Function resetState;

  MyWallet({this.resetState});

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: RefreshIndicator(
        onRefresh: () async {
          // await Future.delayed(Duration(seconds: 0));
          await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
          await Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    color: kDefaultColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 40),
                        Text(
                          'TOTAL BALANCE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 40),
                        Flexible(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              '${mBalance.data.balance}',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4,
                    right: 10.0,
                    left: 10.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      // List All Asset
                      WalletList(),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            ReuseButton.getItem(_lang.translate('send'),
                                () async {
                              await MyBottomSheet().trxOptions(
                                  context: context,
                                  portfolioList: [],
                                  resetState: resetState);
                            }, context),
                            SizedBox(
                              height: 10,
                            ),
                            ReuseButton.getItem(_lang.translate('recieve'), () {
                              Navigator.pushNamed(context, MyQrView);
                            }, context)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
