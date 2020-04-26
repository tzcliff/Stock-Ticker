import 'package:flutter/material.dart';
import 'package:fluttermodule/backtester/backtester.dart';
import 'package:fluttermodule/models/model.dart';
import 'package:fluttermodule/models/model_data.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'backtester_result_screen.dart';

class ChooseModelScreen extends StatefulWidget {
//  final String symbol;
  final String symbol;
  ChooseModelScreen({@required this.symbol});
  bool showSpinner = false;

  @override
  _ChooseModelScreenState createState() => _ChooseModelScreenState();
}

class _ChooseModelScreenState extends State<ChooseModelScreen> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: widget.showSpinner,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: Provider.of<ModelData>(context).modelsCount,
          itemBuilder: (context, index) {
            final Model model = Provider.of<ModelData>(context).models[index];
            return GestureDetector(
              onTap: () async {
                try {
                  BackTester backTester =
                      BackTester(symbol: widget.symbol, model: model);
                  List<Widget> result = await backTester.backTest();

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultScreen(
                      result: result,
                      userAction: model.action,
                      modelName: model.name,
                      symbol: widget.symbol,
                    );
                  }));
<<<<<<< HEAD
                } catch (e) {
                  print(e);
                }
=======
                } catch (e) {}
>>>>>>> master
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
      ),
    );
  }
}
