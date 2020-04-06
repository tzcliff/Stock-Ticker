import 'package:flutter/material.dart';
import 'package:fluttermodule/components/model_item.dart';
import 'package:fluttermodule/models/model.dart';
import 'add_model_screen.dart';
import 'package:fluttermodule/models/model_data.dart';
import 'package:provider/provider.dart';

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
          child: ListView.builder(
            itemCount: Provider.of<ModelData>(context).modelsCount,
            itemBuilder: (context, index) {
              //print(Provider.of<ModelData>(context).modelsCount);
              final Model model = Provider.of<ModelData>(context).models[index];
              //print(model.name);
              return ModelItem(name: model.name);
            },
          ),
        ),
      ],
    );
  }
}
