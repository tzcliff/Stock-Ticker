import 'package:flutter/material.dart';

import 'package:fluttermodule/models/model.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/models/conditional.dart';
import 'package:fluttermodule/screens/add_model_screen.dart';
import 'package:fluttermodule/components/icon_round_button.dart';

class ModelInfoScreen extends StatefulWidget {
  final Model model;

  const ModelInfoScreen({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _ModelInfoScreenState createState() => _ModelInfoScreenState();
}

class _ModelInfoScreenState extends State<ModelInfoScreen> {
  List<ConditionalListTile> list = [];

  void populateConditionalList() {
    for (Conditional conditional in widget.model.conditionals) {
      list.add(ConditionalListTile(
        conditional: conditional,
      ));
    }
  }

  @override
  void initState() {
    populateConditionalList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: ListTile(
              leading: Text(
                'Name:',
                style: kModelPageTextStyle,
              ),
              trailing: Text(
                widget.model.name,
                style: kModelPageTextStyle,
              ),
            ),
          ),
          Text(
            'Conditionals',
            style: kModelPageTextStyle,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.tealAccent.shade400, width: 3),
            ),
            child: Column(
              children: list,
            ),
          ),
          Container(
            child: ListTile(
              leading: Text(
                'Action:',
                style: kModelPageTextStyle,
              ),
              trailing: Text(
                widget.model.action.toString().split('.').last,
                style: kModelPageTextStyle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconRoundButton(
                size: 45,
                iconData: Icons.edit,
                onPress: () {},
              ),
              IconRoundButton(
                size: 45,
                iconData: Icons.delete,
                onPress: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ConditionalListTile extends StatelessWidget {
  const ConditionalListTile({
    Key key,
    @required this.conditional,
  }) : super(key: key);

  final Conditional conditional;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Text(
          conditional.stockItem.toString().split('.').last,
          style: kModelPageTextStyle,
        ),
        title: Text(
          conditional.trend.toString().split('.').last,
          style: kModelPageTextStyle,
        ),
        trailing: Text(
          conditional.duration.toString() + ' days',
          style: kModelPageTextStyle,
        ),
      ),
    );
  }
}
