import 'package:flutter/material.dart';
import 'package:fluttermodule/backtester/backtester.dart';
import 'package:fluttermodule/components/model_item.dart';
import 'package:fluttermodule/models/model.dart';
import 'package:fluttermodule/models/model_data.dart';
import 'package:fluttermodule/models/stock.dart';
import 'package:fluttermodule/services/stock_service.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'backtester_result_screen.dart';

class ChooseModelScreen extends StatelessWidget {
//  final String symbol;
  final String symbol;
  ChooseModelScreen({@required this.symbol});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: Provider.of<ModelData>(context).modelsCount,
        itemBuilder: (context, index) {
          final Model model = Provider.of<ModelData>(context).models[index];
          return GestureDetector(
            onTap :  () async {
              print(model.name);
              BackTester backTester = BackTester(symbol: symbol, model: model);
              List<Widget> result = await backTester.backTest();
              print(result.length);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResultScreen(
                  result: result,
                  userAction: model.action,
                );
              }));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Material(
                color: Colors.tealAccent.shade400,
                elevation: 5,
                child: Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${model.name}',
                        style: kPriceTextStyle,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
