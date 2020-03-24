import 'package:flutter/material.dart';
import 'package:stock_ticker_ui/constants.dart';

class PricePanel extends StatelessWidget {
  const PricePanel({
    Key key,
    @required this.symbol,
    @required this.lastRefreshed,
    @required this.open,
    @required this.close,
    @required this.high,
    @required this.low,
  }) : super(key: key);

  final symbol;
  final lastRefreshed;
  final open;
  final close;
  final high;
  final low;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              'Stock Ticker',
              style: kMainTextStyle,
            ),
          ),
        ),
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
            '$lastRefreshed',
            style: kPriceTextStyle,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'open: $open',
                style: kPriceTextStyle,
              ),
              Text(
                'close: $close',
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
