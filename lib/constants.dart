import 'package:flutter/material.dart';

//Api Base Url
const baseUrl = 'https://testnet-api.selendra.com';


//Design material
const kDefaultColor = Color(0xFF03A9F4);
const kDefaultRadius = 8.0;
var kDefaultShape =  RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(kDefaultRadius),
);

//Map
const osmMapTemplate =  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
const kDefaultMapZoom = 7.0;
const kDefaultMaxZoom = 19.0;
const kDefaultMinZoom = 7.0;

//Decoration Phone Field
const kDefualtPInputDecoration = InputDecoration(
  labelText: 'Phone Number',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDefaultColor),
    borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent),
      borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
);
 