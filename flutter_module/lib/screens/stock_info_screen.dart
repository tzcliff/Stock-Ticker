import 'package:flutter/material.dart';

import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/screens/search_stock_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';
import 'package:intl/intl.dart';

import 'package:fluttermodule/components/price_panel.dart';

class StockInfoScreen extends StatefulWidget {
  static String id = 'stock_info_screen';
  final dynamic stockData;
  const StockInfoScreen({
    this.stockData,
  });
  @override
  _StockInfoScreenState createState() => _StockInfoScreenState();
}

class _StockInfoScreenState extends State<StockInfoScreen> {
  StockService stockService = StockService();
  int selectedIndex = 0;
  var open;
  var high;
  var low;
  var close;
  var symbol;
  var lastRefreshed;

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
        var formatter = new DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(DateTime.now());
        lastRefreshed = stockData['Meta Data']['3. Last Refreshed'];
        symbol = stockData['Meta Data']['2. Symbol'];
        open = stockData['Time Series (Daily)'][formattedDate]['1. open'];
        high = stockData['Time Series (Daily)'][formattedDate]['2. high'];
        low = stockData['Time Series (Daily)'][formattedDate]['3. low'];
        close = stockData['Time Series (Daily)'][formattedDate]['4. close'];
        print(high);
        print(low);
      } catch (e) {
        print(e);
        symbol = 'Error';
        open = 'Error';
        high = 'Error';
        low = 'Error';
        close = 'Error';
        lastRefreshed = 'Error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PricePanel(
              symbol: symbol,
              lastRefreshed: lastRefreshed,
              open: open,
              close: close,
              high: high,
              low: low)),
    );
  }
}

//    var open = stockData['Time Series (Daily)']['2020-03-23']['1. open'];
