import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';

import 'package:fluttermodule/services/stock_service.dart';

import 'package:fluttermodule/components/price_panel.dart';
import 'package:fluttermodule/api_keys.dart';

import 'package:syncfusion_flutter_charts/charts.dart'; // charts
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

List globalStockList;

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
  String dropdownValue = 'High prices';

  StockService stockService = StockService();
  int selectedIndex = 0;
  var price;
  var high;
  var low;
  var change;
  var symbol;
  var lastTradingDay;

  Future<StockList> futureStock; // create stock object

  @override
  void initState() {
    updateUI(widget.stockData);
    super.initState();
    futureStock =
        fetchStock(symbol); // populate the object with data from the API
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

  String globalDropdownValue = 'High prices';

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
                  onPressed: () {},
                  child: Text(
                    'Apply Model',
                    style: kPriceTextStyle,
                  )),
              FlatButton(
                onPressed: () {},
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
                          text: globalDropdownValue + ' for ' + symbol),
                      series: <LineSeries<Stock, String>>[
                        LineSeries<Stock, String>(
                            dataSource: globalStockList,
                            xValueMapper: (Stock stock, _) => stock.date,
                            yValueMapper: (Stock stock, _) {
                              if (globalDropdownValue == 'Open prices') {
                                return double.parse(stock.open);
                              } else if (globalDropdownValue ==
                                  'Close prices') {
                                return double.parse(stock.close);
                              } else if (globalDropdownValue == 'High prices') {
                                return double.parse(stock.high);
                              } else if (globalDropdownValue == 'Low prices') {
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
          Expanded(
            child: Center(
              child: DropdownButton<String>(
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
                  'High prices',
                  'Low prices',
                  'Open prices',
                  'Close prices',
                  'Volume'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
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

//    var open = stockData['Time Series (Daily)']['2020-03-23']['1. open'];

Future<StockList> fetchStock(String symbol) async {
  // this method fetches our data from the API
  // a future is a Dart class for async operations, a future represents a potential value OR error that will be available at some future time
  final response = await http.get(
      'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=' +
          symbol +
          '&apikey=' +
          kAlphaStockAPIKey); // network request
  // await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return StockList.fromJson(json.decode(response.body)); // get the data
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stock');
  }
}

class Stock {
  final String date;
  final String open;
  final String high;
  final String low;
  final String close;
  final String volume;

  Stock({this.date, this.open, this.high, this.low, this.close, this.volume});

  @override
  String toString() {
    return 'Date: ' +
        this.date +
        ' Open: ' +
        this.open +
        ' High: ' +
        this.high +
        ' Low: ' +
        this.low +
        ' Close: ' +
        this.close +
        ' Volume: ' +
        this.volume;
  }
}

class StockList {
  // this object is just a list of stocks
  final List list;

  StockList({this.list});

  factory StockList.fromJson(Map<String, dynamic> json) {
    // parse the json into data we can use it
    if (json['Time Series (Daily)'] == null) {
      throw Exception(
          "An error has occured. Are you sure you entered a valid stock ticker?");
    }
    int size = json['Time Series (Daily)'].keys.toList().length;

    List<Stock> stockList = [];

    for (int i = 0; i < size; i++) {
      stockList.add(new Stock(
        date: json['Time Series (Daily)'].keys.toList()[i],
        open: json['Time Series (Daily)'].values.toList()[i]['1. open'],
        high: json['Time Series (Daily)'].values.toList()[i]['2. high'],
        low: json['Time Series (Daily)'].values.toList()[i]['3. low'],
        close: json['Time Series (Daily)'].values.toList()[i]['4. close'],
        volume: json['Time Series (Daily)'].values.toList()[i]['5. volume'],
      ));
    }
    return StockList(
      list: stockList,
    );
  }
}
