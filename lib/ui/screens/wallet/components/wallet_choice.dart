import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/wallet/get_wallet/adduserinfo/add_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetWallet extends StatefulWidget {
  final Function onGetWallet;
  final Function showAlertDialog;

  GetWallet(this.onGetWallet, this.showAlertDialog);

  @override
  _GetWalletState createState() => _GetWalletState();
}

class _GetWalletState extends State<GetWallet> {
  
  String alertText;

  Future checkFirstSeen() async {
    SharedPreferences isSeen = await SharedPreferences.getInstance();
    bool _seen = (isSeen.getBool('seen') ?? false);
    if (_seen != true && mBalance.data == null) {
      isSeen.setBool('seen', true);
      alertText = 'Look like you don\'t have a wallet yet!';
      widget.showAlertDialog(context, alertText);
    }
  }
  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SvgPicture.asset(
              'assets/undraw_wallet.svg',
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
              placeholderBuilder: (context) => Center(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          
          Container(
            width: MediaQuery.of(context).size.width/1.5,
            child: ReuseButton.getItem(
              "Get ${AppLocalizeService.of(context).translate('wallet')}", () async {
                await StorageServices.fetchData(DbKey.guestAcc).then((value) async {

                  // Sign In By User
                  if (value == null){
                    widget.onGetWallet();
                  }
                  // Guest Account 
                  else {
                    await requestSignUpDialog(context);
                  }
                });
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserInfoScreen()));
              }, 
              context
            )
          ),
        ],
      ),
    );
  }
}
