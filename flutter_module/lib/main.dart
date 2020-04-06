import 'package:flutter/material.dart';
import 'package:fluttermodule/models/model_data.dart';
import 'package:fluttermodule/screens/home_screen.dart';
import 'package:fluttermodule/screens/login_screen.dart';
import 'package:fluttermodule/screens/martket_screen.dart';
import 'package:fluttermodule/screens/model_screen.dart';
import 'package:fluttermodule/screens/registration_screen.dart';
import 'package:fluttermodule/screens/search_stock_screen.dart';
import 'package:fluttermodule/screens/watchlist_screen.dart';
import 'package:fluttermodule/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) {
        return ModelData();
      })
    ],
    child: MaterialApp(
      home: HomeScreen(),
      theme: ThemeData.dark(),
      initialRoute: HomeScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        MarketScreen.id: (context) => MarketScreen(),
        ModelScreen.id: (context) => ModelScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SearchStockScreen.id: (context) => SearchStockScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        WatchlistScreen.id: (context) => WatchlistScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    ),
  ));
}

// class StockTicker extends StatefulWidget {
//   @override
//   _StockTickerState createState() => _StockTickerState();
// }

// class _StockTickerState extends State<StockTicker> {
//   var stockData;
//   // void getStockInfo() async {
//   //   StockService stockService = StockService();
//   //   this.stockData = await stockService.getStockBySymbol('FB');
//   //   Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //     return StockInfoScreen(stockData: this.stockData);
//   //   }));
//   // }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SpinKitWave(
//           color: Colors.white,
//           size: 100,
//         ),
//       ),
//     );
//   }
// }
