import 'package:flutter/material.dart';
//import 'package:selendra_marketplace_app/all_export.dart';
import 'components/pin_screen.dart';

class OTPScreen extends StatefulWidget {

  final String phoneNumber, password;
  OTPScreen(this.phoneNumber, this.password);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: PinScreen(widget.phoneNumber, widget.password),
        )
      ),
    );
  }
}

/*class PinScreen extends StatefulWidget {
  final String phoneNumber, password;
  PinScreen(this.phoneNumber, this.password);
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  bool _isLoading = false, _isCounting = true;
  String alertText;
  int _second = 30;
  Timer _timer;
  List<String> currentPin = ["", "", "", "", "", ""];

  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent));
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          _isCounting = true;
          _second = 30;
          startTimer();
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertText),
      content: Text("Please check again. "),
      actions: [
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

  successDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertText),
      content: Text("Please check again. "),
      actions: [
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_second < 1) {
                timer.cancel();
                _isCounting = false;
              } else {
                _second = _second - 1;
              }
            }));
  }

  void checkVerify(String verifyOTP) async {
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
          'phone': widget.phoneNumber,
          'verification_code': verifyOTP,
        }));
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      var responseBody = json.decode(response.body);
      try {
        alertText = responseBody['error']['message'];
        showAlertDialog(context);
        for (int i = 0; i < 6; i++) {
          clearPin();
        }
      } catch (e) {
        await ApiPostServices()
            .signInByPhone(widget.phoneNumber, widget.password, context);
        alertText = responseBody['message'];
        successDialog(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserInfo()));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  onResendCode(String phoneNumber) async {
    await ApiPostServices().resendCode(phoneNumber).then((value) {
      alertText = value;
      showAlertDialog(context);
    });
  }

  int pinIndex = 0;

  pinIndexSetup(String text) {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 6) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    currentPin.forEach((element) {
      strPin += element;
    });
    if (pinIndex == 6) {
      checkVerify(strPin);
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
      case 5:
        pinFiveController.text = text;
        break;
      case 6:
        pinSixController.text = text;
        break;
    }
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 6) {
      setPin(pinIndex, "");
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      'Enter the OTP Pin',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: kDefualtColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'OTP was send to: ' + widget.phoneNumber,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: kDefualtColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _isCounting
                        ? Text('Invalid in $_second seconds')
                        : Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              child: Text(
                                'Resend Code',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                onResendCode(widget.phoneNumber);
                              },
                            )),
                    SizedBox(
                      height: 50,
                    ),
                    _buildPinRow(),
                    SizedBox(
                      height: 50,
                    ),
                    ReuseNumPad(pinIndexSetup, clearPin),
                    // _buildNumberPad(),
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
        ReusePinNum(outlineInputBorder, pinFiveController),
        ReusePinNum(outlineInputBorder, pinSixController),
      ],
    );
  }
}*/
