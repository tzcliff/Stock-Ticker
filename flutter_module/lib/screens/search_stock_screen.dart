import 'package:flutter/material.dart';

import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/screens/stock_info_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';

class SearchStockScreen extends StatefulWidget {
  static String id = 'search_stock_screen';
  @override
  _SearchStockScreenState createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  String stockSymbol;
  StockService stockService = StockService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    stockSymbol = value;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: kSearchStockTextFieldInputDecoration,
                ),
              ),
              FlatButton(
                onPressed: () async {
                  if (stockSymbol != null) {
                    print(stockSymbol);
                    var stockData =
                        await stockService.getStockBySymbol(stockSymbol);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return StockInfoScreen(
                        stockData: stockData,
                      );
                    }));
                  }
                },
                child: Text(
                  'Get Stock',
                  style: kSearchButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
