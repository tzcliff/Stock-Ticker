import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';

class ResultItem extends StatelessWidget {
  String firstPrice;
  String secondPrice;
  String whetherValid;
  String date;

  ResultItem(
      {@required this.firstPrice,
      @required this.secondPrice,
      @required this.whetherValid,
      @required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        elevation: 5,
        color: Colors.tealAccent.shade400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  date,
                  style: kBottomBarTextStyle,
                )),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(6.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        'Buy/Sell Price: ' + firstPrice,
                        textAlign: TextAlign.left,
                        style: kModelPageTextStyle,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        'Next Day Price:' + secondPrice,
                        textAlign: TextAlign.left,
                        style: kModelPageTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(6.0),
              child: (whetherValid == 'valid')
                  ? Icon(
                      Icons.check,
                      size: 30,
                      color: Colors.lightGreenAccent,
                    )
                  : Icon(
                      Icons.clear,
                      size: 30,
                      color: Colors.redAccent,
                    ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
