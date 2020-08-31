import 'package:flutter/material.dart';

//Api Base Url
const baseUrl = 'https://testnet-api.selendra.com';


//Design material
const kDefualtColor = Color(0xFF03A9F4);
const kDefualtRadius = 8.0;

//Map

const osmMapTemplate =  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
const kDefaultMapZoom = 7.0;
const kDefaultMaxZoom = 19.0;
const kDefaultMinZoom = 7.0;

//Decoration Phone Field
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
 