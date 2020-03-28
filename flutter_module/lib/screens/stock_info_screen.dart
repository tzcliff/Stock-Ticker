import 'package:flutter/material.dart';

import 'package:fluttermodule/services/stock_service.dart';
import 'package:intl/intl.dart';

import 'package:fluttermodule/components/price_panel.dart';

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
  StockService stockService = StockService();
  int selectedIndex = 0;
  var price;
  var high;
  var low;
  var change;
  var symbol;
  var lastTradingDay;

  @override
  void initState() {
    updateUI(widget.stockData);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PricePanel(
              symbol: symbol,
              lastTradingDay: lastTradingDay,
              price: price,
              change: change,
              high: high,
              low: low)),
    );
  }
}

//    var open = stockData['Time Series (Daily)']['2020-03-23']['1. open'];
