import 'package:flutter/material.dart';
import 'package:fluttermodule/components/model_item.dart';
import 'add_model_screen.dart';

class ModelScreen extends StatelessWidget {
  static String id = 'model_screen';

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddModelScreen(),
                      ),
                    ),
                  );
                },
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
            ],
          ),
        ),
      ],
    );
  }
}
