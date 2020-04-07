import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/components/rounded_button.dart';
import 'package:fluttermodule/models/model.dart';
import 'package:provider/provider.dart';
import 'package:fluttermodule/models/model_data.dart';

class AddModelScreen extends StatefulWidget {
  @override
  _AddModelScreenState createState() => _AddModelScreenState();
}

class _AddModelScreenState extends State<AddModelScreen> {
  String modelName;
  @override
  Widget build(BuildContext dcontext) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Model Name',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            textAlign: TextAlign.center,
            autofocus: true,
            onChanged: (value) {
              modelName = value;
              print(modelName);
            },
            decoration: kCreateModelTextFieldDecoration.copyWith(
                hintText: 'Enter your Model Name'),
          ),
          Center(
            child: RoundedButton(
              onPressed: () {
                Model model = Model(name: modelName);
                Provider.of<ModelData>(context, listen: false).addModel(model);
                Navigator.pop(context);
              },
              color: Colors.tealAccent.shade400,
              title: 'Add',
            ),
          ),
        ],
      ),
    );
  }
}
