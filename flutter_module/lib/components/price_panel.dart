import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';

class PricePanel extends StatelessWidget {
  const PricePanel({
    Key key,
    @required this.symbol,
    @required this.lastTradingDay,
    @required this.price,
    @required this.change,
    @required this.high,
    @required this.low,
  }) : super(key: key);

  final symbol;
  final lastTradingDay;
  final price;
  final change;
  final high;
  final low;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text(
              '$symbol',
              style: kMainTextStyle.copyWith(fontSize: 35),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '$lastTradingDay',
            style: kPriceTextStyle,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'price: $price',
                style: kPriceTextStyle,
              ),
              Text(
                'change: $change%',
                style: kPriceTextStyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'high $high',
                style: kPriceTextStyle,
              ),
              Text(
                'low $low',
                style: kPriceTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
