import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/get_wallet/adduserinfo/add_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String alertText;

  List<String> currentPin = ["", "", "", ""];
  String _countryCode = 'KH';
  String value = "Opp! You need to verify your phone number first";
  bool _seen = false;
  PrefService _pref = PrefService();
  bool isCorrect = true, _isLoading = false, _isBtnOneTap = false;

  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();

  TextEditingController _phoneController;
  
  int pinIndex = 0;
  
  @override
  void initState() {
    _phoneController = TextEditingController(text: '');
    clearPinStorage();
    super.initState();
  }

  void clearPinStorage() async {
    await StorageServices.removeKey('first');
    await StorageServices.removeKey('pin');
  }

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: Colors.transparent),
  );

  pinIndexSetup(String text) {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 4) {
      pinIndex++;
    }
    
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";

    currentPin.forEach((element) {
      strPin += element;
    });

    if (pinIndex == 4) {
      for (int i = 0; i < 6; i++) {
        clearPin();
      }
      firstPin(strPin);
      //onGetWallet(strPin);
    }
  }

  void firstPin(String pin) async {
    SharedPreferences isSeen = await SharedPreferences.getInstance();
    SharedPreferences isPin = await SharedPreferences.getInstance();

    _seen = (isSeen.getBool('first') ?? false);
    if (_seen != true) {
      setState(() {
        _seen = true;
        isSeen.setBool('first', true);
        isPin.setString('pin', pin);
      });
    } else {
      isPinMatch(pin);
    }
  }

  void isPinMatch(String pin) {
    _pref.read('pin').then((onValue) {
      if (pin == onValue) {
        onGetWallet(pin);
      } else {
        setState(() {
          isCorrect = false;
        });
      }
    });
  }

  Future<void> onGetWallet(String _pin) async {
    setState(() {
      _isLoading = true;
    });


    // 1 Get Wallet
    try {
      await UserProvider().getWallet(_pin).then((value) async{// tmp

        // 2. Show Verify Option Button
        if (value['code'] == '001') {
          bool actionVerify = await AllDialog().verifyDialog(context, value['message'], _phoneCodePick(), sendCode);

          // 3. Show Add Phone Number Dialog
          if (actionVerify == true){
            var addPhoneRes = await showDialog(
              barrierDismissible: false,
              builder: (context) => AllDialog().addPhoneNumberDialog(context, _phoneCodePick(), sendCode),
              context: context
            );

            // Post Request Add Phone
            if (addPhoneRes == true) {
              bool sendCodeRes = await sendCode(); //tmp

              // 4. SMS Verification
              if (sendCodeRes == true){
                var verifyPinRes = await AllDialog().verifyPinDialog(context, checkVerify);

                if (verifyPinRes != null){

                  // Check Verify Again Request Wallet Again
                  await checkVerify(verifyPinRes); 

                  // // Close Loading For The First TIme
                  // setState(() {
                  //   _isLoading = false;
                  // });
                }
              }
            }
          }

        } else if (value['message'].containsKey('wallet')) {//if (mBalance.data != null) { tmp
          await _pref.read('seed').then((onValue) async {// tmp
            if (onValue != null) {
              await _displayWalletInfo(context, onValue);

              // If Sign Up By Email
              await StorageServices.fetchData('user').then((value) async {

                if (value['email'] != null) {
                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  AddUserInfoScreen()));
                }
                else {
                  // Refetch User Data
                  await Provider.of<UserProvider>(context, listen: false).localFetchProfile();
                  await Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
                  // Close Fill PIn
                  Navigator.pop(context);
                }
              });

              // // Close PIN Dialog
              // Navigator.pop(context);
            } else {
              await ReuseAlertDialog().successDialog(context, value);
            }
          });// tmp
        }
        
      }); //tmp
    } catch (e){
      // print(e);
    }

    // Close Loading After Succssfully Get Wallet And Refetch Portfolio
    if (mounted){
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> sendCode() async {
    var res;
    if (_phoneController.text.isNotEmpty) {
      FocusManager.instance.primaryFocus.unfocus();
      await AuthProvider().addPhoneNumber(AppServices.removeZero(_phoneController.text)).then((onValue) async {
        if (onValue == 'Something went wrong on our end') {

          // Remove PIN To Refill First PIN
          await StorageServices.removeKey('pin');

          // Refill Phone Number, Step 2 again
          await AllDialog().verifyDialog(context, onValue, _phoneCodePick(), sendCode);
        } else {
          res = true;
        }
      });
    }
    return res;
  }

  // Verify SMS Code With Phone Number To Activate Account
  Future checkVerify(String verifyCode) async {
    _pinPutController.text = '';

    await AuthProvider().accountConfirmationPhone(AppServices.removeZero(_phoneController.text), verifyCode).then(// tmp
      (onValue) async { //tmp
        if (onValue.containsKey("error")){
          await AllDialog().simpleAlertDialog(context, "${onValue['error']['message']}");

          // Remove PIN To Show First PIN 
          await StorageServices.removeKey('pin');
          await StorageServices.removeKey('first');

          _seen = false;

          // Refill Phone Number, Step 2 again
          // await AllDialog().verifyDialog(context, onValue['error']['message'], _phoneCodePick(), sendCode);
        } else{
          await AllDialog().simpleAlertDialog(context, "${onValue['message']}");

          // Remove PIN To Show First PIN 
          _seen = false;

          await _pref.read('pin').then((myValue) async {
            await onGetWallet(myValue);
          });
        }
      },// tmp
    );// tmp
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
    }
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 4) {
      setPin(pinIndex, "");
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  bool checkUserCopy() {
    if (_isBtnOneTap) {
      return true;
    }
    return false;
  }

  Future _displayWalletInfo(BuildContext context, String _seed) async {
    var _lang = AppLocalizeService.of(context);
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
              ),
              title: Text(_lang.translate('wallet_information')),
              content: Container(
                // height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Please keep your secure key. Copy it to continue. This secret key will only be showed to you once.\n\nSelendra will not be able to help you recover it if lost'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _lang.translate('private_key'),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                            elevation: 2,
                            color: Colors.grey[50],
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  InfoRow(
                                    '$_seed',
                                    () {
                                      Clipboard.setData(ClipboardData(text: _seed))
                                          .then((value) {
                                        setState(() {
                                          _isBtnOneTap = true;
                                        });
                                      });
                                    },
                                  )
                                ],
                              ),
                            )),
                        _isBtnOneTap
                            ? Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                _lang.translate('copied'),
                                style: TextStyle(
                                    fontSize: 12, color: kDefaultColor),
                              ),
                            )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                    child: Text('Done'),
                    onPressed: () => checkUserCopy()
                        ? Navigator.pop(context)
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     '/root', (Route<dynamic> route) => false)
                        : null),
              ],
            );
          },
        );
      },
    );
  }

  Widget _phoneCodePick() {
    return Container(
      height: 70,
      child: IntlPhoneField(
        controller: _phoneController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(9),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          labelText: AppLocalizeService.of(context).translate('phone_hint'),
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefaultColor),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
        ),
        initialCountryCode: _countryCode,
        validator: (value) => value = value.isEmpty
            ? AppLocalizeService.of(context).translate('phone_number_is_number')
            : null,
        onChanged: (phone) {
          // _phoneNumber = phone.completeNumber.toString();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SafeArea(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  children: <Widget>[
                    _seen
                        ? Text(
                            _lang.translate('reenter_to_confirm'),
                            style: titleTextStyle,
                          )
                        : Text(
                            _lang.translate('enter_4digit_code'),
                            style: titleTextStyle,
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    isCorrect
                        ? Container()
                        : Text(_lang.translate('password_not_match'),
                            style: TextStyle(color: Colors.red)),
                    SizedBox(
                      height: 50,
                    ),
                    _buildPinRow(),
                    SizedBox(
                      height: 50,
                    ),
                    ReuseNumPad(pinIndexSetup, clearPin),
                    //_buildNumberPad()
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ReusePinNum(outlineInputBorder, pinOneController),
        ReusePinNum(outlineInputBorder, pinTwoController),
        ReusePinNum(outlineInputBorder, pinThreeController),
        ReusePinNum(outlineInputBorder, pinFourController),
      ],
    );
  }
}
