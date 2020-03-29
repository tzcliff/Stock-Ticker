import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/components/index_item.dart';

class MarketScreen extends StatefulWidget {
  static String id = 'market_screen';
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              IndexItem(
                symbol: 'Dow Jones',
                price: 21636.78,
              ),
              IndexItem(
                symbol: 'Nasdaq',
                price: 7502.38,
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
