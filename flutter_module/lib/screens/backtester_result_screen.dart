import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/models/enums.dart';

import '../constants.dart';

class ResultScreen extends StatelessWidget {
  final List<Widget> result;
  final UserAction userAction;
  final String modelName;
  final String symbol;

  ResultScreen(
      {@required this.result,
      @required this.userAction,
      this.modelName,
      this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.clear,
                size: 30,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
                child: Column(
              children: <Widget>[
                Text(
                  this.symbol,
                  style: kMainTextStyle,
                ),
                Text(
                  this.modelName,
                  style: kPriceTextStyle,
                ),
              ],
            )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Model Trading(${userAction.toString().split('.').last}) - Past 20 years:",
                  style: kPriceTextStyle,
                ),
              ),
            ),
          ),
          // Center(
          //     child: Text(
          //         'User Action: ' + userAction.toString().split('.').last,
          //         style: kMainTextStyle)),
          Expanded(
              flex: 4,
              child: ListView(
                children: result,
              ))
        ]),
      ),
    ));
  }
}
