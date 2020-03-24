import 'package:flutter/material.dart';

const kMainTextStyle =
    TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'Baloo2');
const kPriceTextStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Baloo2');

const kBottomBarTextStyle = TextStyle(fontFamily: 'Baloo2');

const String kAlphaStockAPIKey = 'XYII374F30NG3EVQ';

const kSearchStockTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.show_chart,
    color: Colors.white,
  ),
  hintText: 'Enter Stock Symbol',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontFamily: 'Baloo2',
  ),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none),
);

const kSearchButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Baloo2',
);
