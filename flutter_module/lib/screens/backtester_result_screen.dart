import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ResultScreen extends StatelessWidget {
  final List result;

  ResultScreen({@required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(child: Text('Back Testing Result', style: kMainTextStyle))
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(

            itemCount: result.length,
            itemBuilder: (context, index) {
              final dynamic date = result[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Material(
                  color: Colors.tealAccent.shade400,
                  elevation: 5,
                  child: Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          date.toString(),
                          style: kPriceTextStyle,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
