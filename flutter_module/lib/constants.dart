import 'package:flutter/material.dart';

const kMainTextStyle =
    TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'Baloo2');
const kPriceTextStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Baloo2');

const kBottomBarTextStyle = TextStyle(fontFamily: 'Baloo2');

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

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.tealAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kCreateModelTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.tealAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
