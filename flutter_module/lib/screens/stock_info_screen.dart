import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/screens/choose_model_screen.dart';
import 'package:fluttermodule/screens/home_screen.dart';
import 'package:fluttermodule/screens/kline_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';
import 'package:fluttermodule/components/price_panel.dart';
import 'package:fluttermodule/models/stock.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // charts
import 'dart:async';
import 'package:flutter/foundation.dart'; // for debugPrint()
import 'package:fluttermodule/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermodule/models/watchlist_data.dart';
import 'package:provider/provider.dart';

List<Stock> globalStockList;

class StockInfoScreen extends StatefulWidget {
  static String id = 'stock_info_screen';
  final dynamic stockData;
  const StockInfoScreen({
    @required this.stockData,
  });
  @override
  _StockInfoScreenState createState() => _StockInfoScreenState();
}

class _StockInfoScreenState extends State<StockInfoScreen> {
  String dropdownValue = 'High';
  String intervalValue = '1day';
  String uid;

  StockService stockService = StockService();
  int selectedIndex = 0;
  var price;
  var high;
  var low;
  var change;
  var symbol;
  var lastTradingDay;

  Future<StockList> futureStock; // create stock object
  StockList stockList;

  @override
  void initState() {
    updateUI(widget.stockData);
    super.initState();
    StockService stockService = new StockService();
    futureStock = stockService.fetchStock(symbol);// populate the object with data from the API

    //print("futureStock: " + futureStock.toString());
    uid = HomeScreen.uid;
  }

  void updateUI(dynamic stockData) {
    setState(() {
      if (stockData == null) {
        symbol = 'Error';
        return;
      }
      try {
        lastTradingDay = stockData['Global Quote']['07. latest trading day'];
        symbol = stockData['Global Quote']['01. symbol'];
        price = stockData['Global Quote']['05. price'];
        high = stockData['Global Quote']['03. high'];
        low = stockData['Global Quote']['04. low'];
        change = stockData['Global Quote']['09. change'];
        print(high);
        print(low);
      } catch (e) {
        print(e);
        symbol = 'Error';
        price = 'Error';
        high = 'Error';
        low = 'Error';
        change = 'Error';
        lastTradingDay = 'Error';
      }
    });
  }

  String globalDropdownValue = 'High';
  String globalIntervalValue = '1day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.clear,
                  size: 30,
                ),
              ),
              FlatButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: ChooseModelScreen(symbol: symbol),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Apply Model',
                    style: kPriceTextStyle,
                  )),
              FlatButton(
                onPressed: () {
                  DatabaseService(uid: uid).addOrRemoveWatchListData(symbol);
                  Provider.of<WatchlistData>(context, listen: false)
                      .addItemIfNotExistBySymbol(
                          symbol: symbol, price: double.parse(price));
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: FutureBuilder<StockList>(
                // a FutureBuilder is a Widget that builds itself based on the last interaction with a future
                future: futureStock, // future object
                builder: (context, snapshot) {
                  // follow some build strategy
                  if (snapshot.hasData) {
                    globalStockList = snapshot.data.list;
                    return SfCartesianChart(
                      // chart library: https://pub.dev/packages/syncfusion_flutter_charts
                      primaryXAxis: CategoryAxis(),
                      borderColor: Colors.white,
                      borderWidth: 2,
                      // Sets 15 logical pixels as margin for all the 4 sides.
                      margin: EdgeInsets.all(15),
                      title: ChartTitle(
                          text: globalDropdownValue + ' for ' + symbol + ' (' + globalIntervalValue + ')'),
                      series: <LineSeries<Stock, String>>[
                        LineSeries<Stock, String>(
                            dataSource: globalStockList,
                            xValueMapper: (Stock stock, _) => stock.date,
                            yValueMapper: (Stock stock, _) {
                              if (globalDropdownValue == 'Open') {
                                return double.parse(stock.open);
                              } else if (globalDropdownValue == 'Close') {
                                return double.parse(stock.close);
                              } else if (globalDropdownValue == 'High') {
                                return double.parse(stock.high);
                              } else if (globalDropdownValue == 'Low') {
                                return double.parse(stock.low);
                              } else {
                                return double.parse(stock.volume);
                              }
                            }),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              //child: Image(image: AssetImage('images/stock_graph.jpg')),
              // child: Text(
              //   'Stock Ticker',
              //   style: kMainTextStyle,
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    globalDropdownValue = newValue;
                  });
                },
                items: <String>[
                  'High',
                  'Low',
                  'Open',
                  'Close',
                  'Volume'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return KLineScreen(
                        symbol: symbol,
                      );
                    }));
                },
                child: Text(
                  'K Line',
                  style: kPriceTextStyle,
                )
              ),
              DropdownButton<String>(
                value: intervalValue,
                icon: Icon(Icons.arrow_downward),
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    intervalValue = newValue;
                    globalIntervalValue = newValue;
                    if (globalIntervalValue == '1day') {
                      futureStock = stockService.fetchStock(symbol);
                    }
                    else {
                      futureStock = stockService.fetchStockPeriod(symbol, globalIntervalValue);
                    }
                  });
                },
                items: <String>[
                  '1min',
                  '5min',
                  '15min',
                  '30min',
                  '60min',
                  '1day',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: PricePanel(
                symbol: symbol,
                lastTradingDay: lastTradingDay,
                price: price,
                change: change,
                high: high,
                low: low),
          ),
        ],
      )),
    );
  }
}
