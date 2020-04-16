import 'package:flutter/material.dart';

class resultItem  extends StatelessWidget {
  String firstPrice;
  String secondPrice;
  String whetherValid;
  String date;

  resultItem({@required this.firstPrice, @required this.secondPrice, @required this.whetherValid, @required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 5,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(date)
              ),
              Column(
                children: <Widget>[
                  Container (
                    padding: const EdgeInsets.all(16.0),
                    child: new Column (
                      children: <Widget>[
                        new Text ('Buy/Sell Price: '+ firstPrice, textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                  Container (
                    padding: const EdgeInsets.all(16.0),
                    child: new Column (
                      children: <Widget>[
                        new Text ('Next Day Price:' + secondPrice, textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ],
              ),
              Container (
                padding: const EdgeInsets.all(16.0),
                child: new Column (
                  children: <Widget>[
                    new Text ('Strategy Validity: ', textAlign: TextAlign.left),
                    new Text (whetherValid, textAlign: TextAlign.left),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );;
  }

}
