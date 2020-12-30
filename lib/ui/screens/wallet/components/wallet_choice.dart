import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletChoice extends StatefulWidget {
  final Function onGetWallet;
  final Function showAlertDialog;

  WalletChoice(this.onGetWallet, this.showAlertDialog);

  @override
  _WalletChoiceState createState() => _WalletChoiceState();
}

class _WalletChoiceState extends State<WalletChoice> {
  String alertText;

  Future checkFirstSeen() async {
    SharedPreferences isSeen = await SharedPreferences.getInstance();
    bool _seen = (isSeen.getBool('seen') ?? false);
    if (_seen != true && mBalance.token == null) {
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
    return Responsive(
      mobile: wallerChoiceMobile(),
      desktop: wallerChoiceDesktop(),
    );
  }

  Widget wallerChoiceMobile() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'images/undraw_wallet.svg',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                placeholderBuilder: (context) => Center(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            ReuseButton.getItem(
                AppLocalizeService.of(context).translate('wallet'), () {
              widget.onGetWallet();
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserInfoScreen()));
            }, context),
          ],
        ),
      ),
    );
  }

  Widget wallerChoiceDesktop() {
    return Row(
      children: [
        Flexible(flex: 2, child: Container()),
        Container(
          width: 800,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      'images/undraw_wallet.svg',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    // child: SvgPicture.asset(
                    //   'images/undraw_wallet.svg',
                    //   height: MediaQuery.of(context).size.height * 0.2,
                    //   width: MediaQuery.of(context).size.height * 0.2,
                    //   placeholderBuilder: (context) => Center(),
                    // ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ReuseButton.getItem(
                        AppLocalizeService.of(context).translate('wallet'), () {
                      widget.onGetWallet();
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserInfoScreen()));
                    }, context),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(flex: 2, child: Container()),
      ],
    );
  }
}
