import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ReusePinAnimate extends StatelessWidget {
  final ValueChanged<String> onSubmit;

  ReusePinAnimate({this.onSubmit});

  final FocusNode pinPutFocusNode = FocusNode();
  final TextEditingController pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: animatingPinBorders(context),
    );
  }

  Widget animatingPinBorders(context) {
    BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border.all(color: Colors.greenAccent),
      borderRadius: BorderRadius.circular(kDefaultRadius),
    );
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.1,
      child: PinPut(
        fieldsCount: 6,
        eachFieldMargin: EdgeInsets.symmetric(horizontal: 2),
        eachFieldHeight: 40,
        onSubmit: onSubmit,
        focusNode: pinPutFocusNode,
        controller: pinPutController,
        submittedFieldDecoration: pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(kDefaultRadius)),
        pinAnimationType: PinAnimationType.slide,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration.copyWith(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kDefaultColor.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
