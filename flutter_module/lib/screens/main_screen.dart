import 'package:flutter/material.dart';

import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/screens/search_stock_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';

import 'price_panel.dart';

class MainScreen extends StatefulWidget {
  final dynamic stockData;
  const MainScreen({
    this.stockData,
  });
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
        lastRefreshed = stockData['Meta Data']['3. Last Refreshed'];
        symbol = stockData['Meta Data']['2. Symbol'];
        open = stockData['Time Series (Daily)'][lastRefreshed]['1. open'];
        high = stockData['Time Series (Daily)'][lastRefreshed]['2. high'];
        low = stockData['Time Series (Daily)'][lastRefreshed]['3. low'];
        close = stockData['Time Series (Daily)'][lastRefreshed]['4. close'];
        print(high);
        print(low);
      } catch (e) {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 55,
        height: 55,
        child: FloatingActionButton(
          onPressed: () async {
            var stockSymbol = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return SearchStockScreen();
            }));
            if (stockSymbol != null) {
              print(stockSymbol);
              var stockData = await stockService.getStockBySymbol(stockSymbol);
              updateUI(stockData);
            }
          },
          child: Icon(Icons.search),
          elevation: 4.0,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text(
                'Market',
                style: kBottomBarTextStyle,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              title: Text(
                'Watchlist',
                style: kBottomBarTextStyle,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets),
              title: Text(
                'Models',
                style: kBottomBarTextStyle,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                'Setting',
                style: kBottomBarTextStyle,
              )),
        ],
        currentIndex: selectedIndex,
        onTap: onBottomItemTapped,
        fixedColor: Colors.teal,
      ),
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

  void onBottomItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

//    var open = stockData['Time Series (Daily)']['2020-03-23']['1. open'];
