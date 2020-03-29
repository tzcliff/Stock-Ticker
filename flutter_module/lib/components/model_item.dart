import 'package:flutter/material.dart';

import 'package:fluttermodule/constants.dart';

class ModelItem extends StatelessWidget {
  final String name;

  const ModelItem({
    @required this.name,
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
                '$name',
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
