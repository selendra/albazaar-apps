import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/qr_scanner/qr_scanner.dart';

// import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:contacts_service/contacts_service.dart';

class MyBottomSheetItem extends StatelessWidget {

  final String subTitle;
  final String icon;
  final Function action;

  MyBottomSheetItem({
    @required this.subTitle,
    @required this.icon,
    @required this.action
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        children: [
          
          SvgPicture.asset('images/icons/$icon', width: 30, height: 30, color: Colors.black),

          MyText(
            top: 6,
            text: subTitle,
            fontSize: 12,
          )
        ],
      )
    );
  }
}

/* -------------------------Transaction Method--------------------------- */

class TrxOptionMethod {

  static PostRequest _postRequest = PostRequest();
  
  static void selectContact(
    BuildContext context,
    List<dynamic> listPortfolio,
    Function resetState
  ) async {

    if (await Permission.contacts.request().isGranted){
      String number = '';
      var response;
      // final PhoneContact _contact = await ContactsService .pickPhoneContact();
      // final Contact _contact = await ContactsService.openDeviceContactPicker();
      // var existingContact = await ContactsService.getContacts();
      // ContactsService.getContactsForPhone("0967056880").then((value) => print(value));
      // print("My contact ${existingContact[0]}");
      //Get Contact And Asign To Number Variable 
      
      // if (_contact != null) {
      //   print(_contact.identifier);
        // _contact.phones.forEach((e) {
        // });
        // await _postRequest.getWalletFromContact(
        //   "+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)  }" // Replace 0 At The First Index To Empty
        // ).then((value) async {
        //   if(value['status_code'] == 200 && value.containsKey('wallet')){
        //     // response = await Navigator.push(
        //     //   context, 
        //     //   MaterialPageRoute(builder: (context) => SubmitTrx(value['wallet'], false, listPortfolio))  
        //     // );
        //     // if (response["status_code"] == 200) {
        //     //   resetState(null, "portfolio");
        //     //   Navigator.pop(context);
        //     // }
        //   } else {
        //     await Components.dialog(
        //       context, 
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           textAlignCenter(text: value['message']),
        //           Container(
        //             margin: EdgeInsets.only(top: 5.0),
        //             child: textAlignCenter(text: "Do you want to invite this number 0${_contact.phoneNumber.number.replaceFirst("0", "", 0)}?")
        //           )
        //         ],
        //       ), 
        //       textMessage(), 
        //       action: FlatButton(
        //         child: Text("Invite"),
        //         onPressed: () async {
        //           Navigator.pop(context); // Close Dialog Invite
        //           Components.dialogLoading(context: context); // Process Loading
        //           var _response = await _postRequest.inviteFriend("+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}");
        //           Navigator.pop(context); // Close Dialog Loading
        //           if (_response != null) {
        //             await Components.dialog(context, Text(_response['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: Colors.black));
        //           }
        //         },
        //       )
        //     );
        //   }
        // });
      // }
    }
  }

  static void navigateFillAddress(BuildContext context, List<dynamic> portfolioList, Function resetState) async {
    var response = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SubmitTrx("", true, []/* portfolioList */))
    );
    if (response['status_code'] == 200) {
      resetState(null, "portfolio");
    }
  }

  /* Scan QR Code */
  static Future scanQR(BuildContext context, List<dynamic> portfolioList, Function resetState) async {
    
    // Scan And Get QR Code
    String _scanResponse = await Navigator.push(context, MaterialPageRoute(builder: (context) => QrScanner(portList: [])));
    Navigator.pop(context, _scanResponse);
    // if (_scanResponse != null){
    //   // Fill Transaction Information
    //   // await Future.delayed(Duration(seconds: 2), () async {
    //   //   await Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTrx(_scanResponse, false, []/* widget.portList */))).then((value) async {
    //   //     if (value != null){
    //   //       // await Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
    //   //       // resetState();
    //   //     }
    //   //   });
    //   // });
    // }
  }
  
}

Widget textAlignCenter({String text: ""}){
  return Text(text, textAlign: TextAlign.center);
}

Widget textMessage({String text: "Message", fontSize: 20.0}){
  return FittedBox(
    child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
  );
}
