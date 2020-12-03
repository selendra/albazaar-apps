import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String alertText;

  List<String> currentPin = ["", "", "", ""];
  String _countryCode = 'KH';
  String _phoneNumber, value;
  bool _seen = false;
  PrefService _pref = PrefService();
  bool isCorrect = true, _isLoading = false, _isBtnOneTap = false;

  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: Colors.transparent),
  );

  void clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('first');
    pref.remove('pin');
  }

  int pinIndex = 0;

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

  sendCode() async {
    if (_phoneNumber != null) {
      FocusManager.instance.primaryFocus.unfocus();
      setState(() {
        _isLoading = true;
      });
      await AuthProvider().addPhoneNumber(_phoneNumber).then((onValue) {
        alertText = onValue;
        if (alertText == 'Something went wrong on our end') {
          setState(() {
            _isLoading = false;
          });
          AllDialog()
              .verifyDialog(context, onValue, _phoneCodePick(), sendCode);
        } else {
          AllDialog().verifyPinDialog(context, checkVerify);
        }
      });
    }
  }

  void checkVerify(String verifyCode) async {
    _pinPutController.text = '';
    setState(() {
      _isLoading = true;
    });
    await AuthProvider().verifyByPhone(_phoneNumber, verifyCode).then(
      (onValue) {
        setState(() {
          _isLoading = false;
        });
        if (onValue != null) {
          AllDialog().simpleAlertDialog(context, onValue);
        }
      },
    );
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
      print(onValue);
      if (pin == onValue) {
        onGetWallet(pin);
      } else {
        setState(() {
          isCorrect = false;
        });
      }
    });
  }

  onGetWallet(String _pin) async {
    setState(() {
      _isLoading = true;
    });
    await UserProvider().getWallet(_pin).then((value) {
      setState(() {
        _isLoading = false;
      });
      print(value);
      if (value == 'Opp! You need to verify your phone number first') {
        AllDialog().verifyDialog(context, value, _phoneCodePick(), sendCode);
      } else if (mBalance.data != null) {
        _pref.read('seed').then((onValue) {
          if (onValue != null) {
            _displayWalletInfo(context, onValue);
          } else {
            ReuseAlertDialog().successDialog(context, value);
          }
        });
      }
    });
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

  _displayWalletInfo(BuildContext context, String _seed) async {
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
                height: 300,
                child: Column(
                  children: [
                    Text(
                        'Please keep your secure key. Copy it to continue. This secret key will only be showed to you once.\n\nSelendra will not be able to help you recover it if lost'),
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
                              child: InfoRow(
                                '\n$_seed',
                                () {
                                  Clipboard.setData(ClipboardData(text: _seed))
                                      .then((value) {
                                    setState(() {
                                      _isBtnOneTap = true;
                                    });
                                  });
                                },
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
                        ? Navigator.of(context).pushNamedAndRemoveUntil(
                            '/root', (Route<dynamic> route) => false)
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
      height: 50,
      child: IntlPhoneField(
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
          _phoneNumber = phone.completeNumber.toString();
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
