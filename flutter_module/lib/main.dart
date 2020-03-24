import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'services/stock_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MaterialApp(
    home: StockTicker(),
    theme: ThemeData.dark(),
  ));
}

class StockTicker extends StatefulWidget {
  @override
  _StockTickerState createState() => _StockTickerState();
}

class _StockTickerState extends State<StockTicker> {
  var stockData;
  void getStockInfo() async {
    StockService stockService = StockService();
    this.stockData = await stockService.getStockBySymbol('FB');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen(stockData: this.stockData);
    }));
  }

  @override
  void initState() {
    getStockInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
