import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseNumPad extends StatelessWidget {
  final Function pinIndexSetup;
  final Function clearPin;

  ReuseNumPad(this.pinIndexSetup, this.clearPin);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildNumberPad(),
    );
  }

  Widget _buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReuseKeyBoardNum(1, () {
                    pinIndexSetup('1');
                  }),
                  ReuseKeyBoardNum(2, () {
                    pinIndexSetup('2');
                  }),
                  ReuseKeyBoardNum(3, () {
                    pinIndexSetup('3');
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReuseKeyBoardNum(4, () {
                    pinIndexSetup('4');
                  }),
                  ReuseKeyBoardNum(5, () {
                    pinIndexSetup('5');
                  }),
                  ReuseKeyBoardNum(6, () {
                    pinIndexSetup('6');
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReuseKeyBoardNum(7, () {
                    pinIndexSetup('7');
                  }),
                  ReuseKeyBoardNum(8, () {
                    pinIndexSetup('8');
                  }),
                  ReuseKeyBoardNum(9, () {
                    pinIndexSetup('9');
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  ReuseKeyBoardNum(0, () {
                    pinIndexSetup('0');
                  }),
                  Container(
                    width: 60,
                    child: MaterialButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: () {
                        clearPin();
                      },
                      child: Icon(
                        Icons.backspace,
                        color: kDefaultColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
