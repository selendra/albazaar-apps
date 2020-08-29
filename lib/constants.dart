import 'package:flutter/material.dart';

const kDefualtColor = Color(0xFF03A9F4);
const kDefualtRadius = 8.0;
const BASE_URL = 'https://testnet-api.selendra.com';

const kDefualtPInputDecoration = InputDecoration(
  labelText: 'Phone Number',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDefualtColor),
    borderRadius: BorderRadius.all(Radius.circular(kDefualtRadius)),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent),
      borderRadius: BorderRadius.all(Radius.circular(kDefualtRadius))),
);
 