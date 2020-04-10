import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/components/index_item.dart';
import 'package:fluttermodule/services/network_service.dart';
import 'dart:math';

class MarketScreen extends StatefulWidget {
  static String id = 'market_screen';
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {

  Future nasdaq;
  Future dowJones;
  var nasVal;
  var dowVal;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    NetworkService networkService = new NetworkService("");
    var dowData;
    var nasdaqData;
    dowJones =  networkService.getDow();
    dowJones.then((value) {
      dowData = value;
      nasdaq =  networkService.getNasdaq();
      nasdaq.then((value) {
        nasdaqData = value;
        updateUI(dowData, nasdaqData);
      });
    });

  }

  void updateUI(dynamic dowData, dynamic nasdaqData) {
    setState(() {
      if (dowData == null) {
        dowVal = 0.0;
        return;
      }
      try {
        var results = dowData["chart"]["result"][0]["indicators"]["quote"][0]["high"][0]; // raw data
        dowVal = results.toStringAsFixed(2);
      } catch (e) {
        print(e);
        dowVal = 0.0;
      }

      if (nasdaqData == null) {
        nasVal = "error1";
        return;
      }
      try {
        var results = nasdaqData["chart"]["result"][0]["indicators"]["quote"][0]["high"][0]; // raw data
        nasVal = results.toStringAsFixed(2);
      } catch (e) {
        print(e);
        nasVal = "error3";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              IndexItem(
                symbol: 'Dow Jones',
                price: double.parse(dowVal),
              ),
              IndexItem(
                symbol: 'Nasdaq',
                price: double.parse(nasVal),
              )
            ],
          ),
        ),
        Expanded(
            child: Center(
          child: Text(
            'News',
            style: kMainTextStyle,
          ),
        )),
      ],
    );
  }
}
