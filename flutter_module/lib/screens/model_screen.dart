import 'package:flutter/material.dart';
import 'package:fluttermodule/components/model_item.dart';

class ModelScreen extends StatefulWidget {
  static String id = 'model_screen';
  @override
  _ModelScreenState createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              ModelItem(name: 'Model 1'),
              ModelItem(name: 'Model 2'),
              ModelItem(name: 'Model 3'),
              ModelItem(name: 'Model 4'),
              ModelItem(name: 'Model 5'),
              ModelItem(name: 'Model 6'),
              ModelItem(name: 'Model 7'),
              ModelItem(name: 'Model 8'),
              ModelItem(name: 'Model 9'),
              ModelItem(name: 'Model 10'),
              ModelItem(name: 'Model 11'),
            ],
          ),
        ),
      ],
    );
  }
}
