import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'info_row.dart';

class WalletPin extends StatefulWidget {
  @override
  _WalletPinState createState() => _WalletPinState();
}

class _WalletPinState extends State<WalletPin> {
  void clearPref() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('first');
    pref.remove('pin');
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          scaffoldBackgroundColor: Colors.white,
        ),
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  clearPref();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: kDefaultColor,
                ),
              ),
            ),
            body: PinScreen(),
          ),
        ));
  }
}

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String alertText;

  List<String> currentPin = ["", "", "", ""];
  String _countryCode = 'KH';
  String _phoneNumber, _verifyPin, value;
  bool _seen = false;
  bool isNotCorrect = false, _isLoading = false, _isBtnOneTap = false;

  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent));

  void clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('first');
    pref.remove('pin');
  }

  onGetWallet(String _pin) async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences isPref = await SharedPreferences.getInstance();
    String firstPin = isPref.getString('pin');
    String _token;
    _token = isPref.get('token');
    if (firstPin == _pin) {
      setState(() {
        isNotCorrect = false;
      });
      print('correct');
      print(_pin);
      await ApiPostServices().getWallet(_pin, _token).then((value) {
        setState(() {
          _isLoading = false;
        });
        print(value);
        alertText = value;
        if (alertText == 'Opp! You need to verify your phone number first') {
          showAlertDialog(context);
          //_displayWalletInfo(context, _pin);
        } else {
          Navigator.pop(context);
          clearPref();
          _displayWalletInfo(context, _pin);
          // Navigator.pop(context);
          // Navigator.push(context,
          // MaterialPageRoute(builder: (context) => WalletInfoScreen()));
        }
      });
    } else {
      setState(() {
        isNotCorrect = true;
      });
    }
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
      checkFirstSeen(strPin);
      //onGetWallet(strPin);
    }
  }

  onAddPhoneNumber() async {
    SharedPreferences isToken = await SharedPreferences.getInstance();
    String _token = isToken.getString('token');
    await ApiPostServices().addPhoneNumber(_token, _phoneNumber).then((value) {
      setState(() {
        _isLoading = false;
      });
      alertText = value;
      print(alertText);
      if (alertText != 'Something went wrong on our end') {
        _verifyPinDialog(context);
      } else {
        showAlertDialog(context);
      }
    });
  }

  void checkVerify(String verifyOTP) async {
    _pinPutController.text = '';
    String apiUrl =
        'https://testnet-api.selendra.com/pub/v1/account-confirmation';
    setState(() {
      _isLoading = true;
    });
    var response = await http.post(apiUrl,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          'phone': _phoneNumber,
          'verification_code': verifyOTP,
        }));
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      var responseBody = json.decode(response.body);
      print(responseBody);
      print(response.body);
      try {
        alertText = responseBody['error']['message'];
        errorDialog(context);
      } catch (e) {
        alertText = responseBody['message'];
        Navigator.pop(context);
        simpleAlertDialog(context);
        /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WalletPin(),
            ));*/
      }
    } else {
      print(response.body);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future checkFirstSeen(String pin) async {
    SharedPreferences isSeen = await SharedPreferences.getInstance();
    SharedPreferences isPin = await SharedPreferences.getInstance();
    _seen = (isSeen.getBool('first') ?? false);

    if (_seen != true) {
      setState(() {
        _seen = true;
      });
      isSeen.setBool('first', true);
      isPin.setString('pin', pin);
      print(pin);
    } else {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => GetWalletScreen(),));
      onGetWallet(pin);
    }
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

  textStyle() {
    return TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: kDefaultColor,
    );
  }

  errorDialog(BuildContext context) async {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text(alertText),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  simpleAlertDialog(BuildContext context) async {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text(alertText),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  bool checkUserCopy() {
    if (_isBtnOneTap) {
      return true;
    }
    return false;
  }

  _displayWalletInfo(BuildContext context, String pin) async {
    SharedPreferences isSeed = await SharedPreferences.getInstance();
    String _seed = isSeed.getString('seed');
    _seed = '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2.';
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(kDefaultRadius)),
                ),
                title: Text('Wallet Information'),
                content: Container(
                  height: 290,
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
                            'Private Key',
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
                                    print('Copy');
                                    Clipboard.setData(
                                            ClipboardData(text: _seed))
                                        .then((value) {
                                      print('success');
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
                                    'Copied',
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
        });
  }

  _verifyPhoneDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          title: Text('Enter your phone Number'),
          content: _phoneCodePick(),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                print('Cancel');
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                if (_phoneNumber != null) {
                  print('Ok');
                  FocusManager.instance.primaryFocus.unfocus();
                  setState(() {
                    _isLoading = true;
                  });
                  Navigator.pop(context);
                  onAddPhoneNumber();
                } else {
                  return null;
                }
              },
            ),
          ],
        );
      },
    );
  }

  _verifyPinDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          title: Text('Enter Verify Code'),
          content: ReusePinAnimate(
            onSubmit: (value) => _verifyPin = value,
          ),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                print('Cancel');
                Navigator.pop(context);
              },
            ),
            FlatButton(
                child: Text('OK'),
                onPressed: () => _pinPutController.text.isNotEmpty
                    ? checkVerify(_verifyPin)
                    : null),
          ],
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Verify"),
      onPressed: () {
        Navigator.pop(context);
        _verifyPhoneDialog(context);
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Oops!!'),
      content: Text(alertText),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _phoneCodePick() {
    return Container(
      height: 50,
      child: IntlPhoneField(
        decoration: InputDecoration(
          labelText: 'Phone Number',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefaultColor),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
        ),
        initialCountryCode: _countryCode,
        maxLength: 10,
        validator: (value) => value = value.isEmpty ? 'Phone is Empty' : null,
        onChanged: (phone) {
          print(phone.completeNumber);
          _phoneNumber = phone.completeNumber.toString();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                            'Re-Enter to Confirm',
                            style: textStyle(),
                          )
                        : Text(
                            'Enter 4-Digit code',
                            style: textStyle(),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    isNotCorrect
                        ? Text('Pw and Confirm Pw does not match')
                        : Container(),
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
