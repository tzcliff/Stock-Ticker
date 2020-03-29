import 'package:flutter/material.dart';

import 'package:fluttermodule/constants.dart';

class IndexItem extends StatelessWidget {
  final String symbol;
  final double price;

  const IndexItem({
    @required this.symbol,
    @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 5,
        child: Padding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$symbol',
                style: kPriceTextStyle,
              ),
              Text(
                '$price',
                style: kPriceTextStyle,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
