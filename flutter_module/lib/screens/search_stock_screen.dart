import 'package:flutter/material.dart';

import 'package:fluttermodule/constants.dart';

class SearchStockScreen extends StatefulWidget {
  @override
  _SearchStockScreenState createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  String stockSymbol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    stockSymbol = value;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: kSearchStockTextFieldInputDecoration,
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, stockSymbol);
                },
                child: Text(
                  'Get Stock',
                  style: kSearchButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
