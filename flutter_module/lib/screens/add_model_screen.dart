import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fluttermodule/components/dropdowns.dart';
import 'package:fluttermodule/components/icon_round_button.dart';
import 'package:fluttermodule/components/rounded_button.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/models/conditional.dart';
import 'package:fluttermodule/models/enums.dart';
import 'package:fluttermodule/models/model.dart';
import 'package:fluttermodule/models/model_data.dart';

List<Conditional> conditionals = [];

class AddModelScreen extends StatefulWidget {
  @override
  _AddModelScreenState createState() => _AddModelScreenState();
}

class _AddModelScreenState extends State<AddModelScreen> {
  // String selectedItem = StockItem.price.toString().split('.').last;
  // String selectedTrend = Trend.increase.toString().split('.').last;
  // int selectedPerid = 2;
  UserAction selectedAction = UserAction.buy;

  List<ConditionalListTile> listTiles = [];
  String modelName;

  void createConditional() {
    conditionals.add(Conditional(
        stockItem: StockItem.price,
        trend: Trend.increase,
        scope: 10,
        duration: 2));
    print(conditionals[conditionals.length - 1].duration.toString());
    setState(() {
      listTiles.add(ConditionalListTile(index: conditionals.length - 1));
    });
  }

  @override
  Widget build(BuildContext dcontext) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Model Name',
            style: kModelPageTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              modelName = value;
            },
            decoration: kCreateModelTextFieldDecoration.copyWith(
                hintText: 'Enter your Model Name'),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Conditionals',
                style: kModelPageTextStyle,
              ),
              IconRoundButton(
                iconData: Icons.add,
                onPress: () {
                  createConditional();
                },
              ),
            ],
          ),
          Column(
            children: listTiles,
          ),
          Text(
            'Action',
            style: kModelPageTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          ModelActionDropdown(
            selected: selectedAction,
            onChange: (value) {
              setState(() {
                selectedAction = value;
              });
            },
          ),
          Center(
            child: RoundedButton(
              onPressed: () {
                Model model = Model(
                  action: selectedAction,
                  name: modelName,
                  conditionals: conditionals,
                );
                Provider.of<ModelData>(context, listen: false).addModel(model);
                conditionals = [];
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

class ConditionalListTile extends StatefulWidget {
  const ConditionalListTile({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  _ConditionalListTileState createState() => _ConditionalListTileState();
}

class _ConditionalListTileState extends State<ConditionalListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: ModelItemDropdown(
          selected: conditionals[widget.index].stockItem,
          onChange: (value) {
            setState(() {
              conditionals[widget.index].stockItem = value;
            });
          },
        ),
        title: ModelTrendDropdown(
          selected: conditionals[widget.index].trend,
          onChange: (value) {
            setState(() {
              conditionals[widget.index].trend = value;
            });
          },
        ),
        trailing: ModelPeriodDropdown(
          selected: conditionals[widget.index].duration,
          onChange: (value) {
            setState(() {
              conditionals[widget.index].duration = value;
            });
          },
        ),
      ),
    );
  }
}
