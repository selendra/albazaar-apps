import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/qr_scanner/qr_scanner.dart';

class MyBottomSheetItem extends StatelessWidget {
  final String subTitle;
  final String icon;
  final Function action;

  MyBottomSheetItem(
      {@required this.subTitle, @required this.icon, @required this.action});

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: action,
        child: Column(
          children: [
            SvgPicture.asset('images/icons/$icon',
                width: 30, height: 30, color: Colors.black),
            MyText(
              top: 6,
              text: subTitle,
              fontSize: 12,
            )
          ],
        ));
  }
}

/* -------------------------Transaction Method--------------------------- */

class TrxOptionMethod {
  static void selectContact(
    BuildContext context,
    List<dynamic> listPortfolio,
    Function resetState,
  ) async {
    PostRequest _postRequest = PostRequest();

    Backend _backend = Backend();

    if (await Permission.contacts.request().isGranted) {
      // String number = '';
      // var response;
      //Get Contact And Asign To Number Variable

      final PhoneContact _contact =
          await FlutterContactPicker.pickPhoneContact();

      if (_contact != null) {
        await _postRequest
            .getWalletFromContact(
                "+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}" // Replace 0 At The First Index To Empty
                )
            .then((value) async {
          _backend.data = json.decode(value.body);
          if (_backend.data['status_code'] == 200 &&
              _backend.data.containsKey('wallet')) {
            _backend.data = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SubmitTrx(
                        _backend.data['wallet'], false, listPortfolio)));
            if (_backend.data["status_code"] == 200) {
              resetState(null, "portfolio");
              Navigator.pop(context);
            }
          } else {
            await Components.dialog(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    textAlignCenter(text: _backend.data['message']),
                    Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: textAlignCenter(
                            text:
                                "Do you want to invite this number 0${_contact.phoneNumber.number.replaceFirst("0", "", 0)}?"))
                  ],
                ),
                textMessage(),
                action: FlatButton(
                  child: Text("Invite"),
                  onPressed: () async {
                    Navigator.pop(context); // Close Dialog Invite
                    Components.dialogLoading(
                        context: context); // Process Loading
                    var _response = await _postRequest.inviteFriend(
                        "+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}");
                    Navigator.pop(context); // Close Dialog Loading
                    if (_response != null) {
                      await Components.dialog(
                          context,
                          Text(
                            _response['message'],
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.done_outline, color: Colors.black));
                    }
                  },
                ));
          }
        });
      }
    }
  }

  static void navigateFillAddress(BuildContext context,
      List<dynamic> portfolioList, Function resetState) async {
    var response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubmitTrx("", true, [] /* portfolioList */)));
    if (response['status_code'] == 200) {
      resetState(null, "portfolio");
    }
  }

  /* Scan QR Code */
  static Future scanQR(BuildContext context, List<dynamic> portfolioList,
      Function resetState) async {
    // Scan And Get QR Code
    return await Navigator.push(context,
        MaterialPageRoute(builder: (context) => QrScanner(portList: [])));

    // if (_scanResponse != null){
    //   // await Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTrx(_scanResponse, false, []/* widget.portList */)));
    //   // Fill Transaction Information
    //   // await Future.delayed(Duration(seconds: 2), () async {
    //   //   await Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTrx(_scanResponse, false, []/* widget.portList */))).then((value) async {
    //   //     if (value != null){
    //   //     }
    //   //   });
    //   // });
    // }
  }
}

Widget textAlignCenter({String text: ""}) {
  return Text(text, textAlign: TextAlign.center);
}

Widget textMessage({String text: "Message", fontSize: 20.0}) {
  return FittedBox(
    child: Text(text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
  );
}
