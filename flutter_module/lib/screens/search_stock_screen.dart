import 'package:flutter/material.dart';

import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/screens/stock_info_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchStockScreen extends StatefulWidget {
  static String id = 'search_stock_screen';
  @override
  _SearchStockScreenState createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  String stockSymbol;
  StockService stockService = StockService();
  TextEditingController txt = TextEditingController();

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
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: txt,
                    onChanged: (value) {
                      stockSymbol = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: kSearchStockTextFieldInputDecoration,
                  ),
                  suggestionsCallback: (stockSymbol) async {
                    return stockService.getStockSearchItems(stockSymbol);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion['1. symbol']),
                      subtitle: Text(suggestion['2. name']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    print(suggestion['1. symbol'].toString());
                    stockSymbol = suggestion['1. symbol'].toString();
                    setState(() {
                      txt.text = stockSymbol;
                    });
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  if (stockSymbol != null) {
                    print(stockSymbol);
                    var stockData =
                        await stockService.getStockQuoteBySymbol(stockSymbol);
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
