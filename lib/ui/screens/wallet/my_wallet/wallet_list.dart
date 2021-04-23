import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class WalletList extends StatefulWidget {
  @override
  _WalletListState createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: wallets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultRadius),
              side: BorderSide(
                color: kDefaultColor,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              onTap: () async {
                if (index == 0){
                  Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
                  Navigator.push(
                    context,
                    RouteAnimation(
                      enterPage: TransactionHistory(
                        title: wallets[index].title,
                        amount: wallets[index].amount,
                        logo: wallets[index].logo,
                      ),
                    ),
                  );
                } else {
                  await Components.dialog(context, Text("This cryptos will coming soon", textAlign: TextAlign.center,), Text("Message"));
                }
              },
              trailing: Text(
                wallets[index].amount,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              leading: Container(
                width: 70, height: 70,
                child: (wallets[index].logo.contains('svg')) ? SvgPicture.asset(wallets[index].logo, width: 50, height: 50) : Image.asset(wallets[index].logo, width: 50, height: 50)
              ),
              title: Text(
                wallets[index].title,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
