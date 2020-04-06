import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/components/watchlist_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermodule/models/stock.dart';
import 'package:fluttermodule/services/stock_service.dart';


class WatchlistScreen extends StatefulWidget {
  static String id = 'watchlist_screen';
//  List<WatchListItem> watchListItems = [
////    WatchListItem(
////      symbol: getUser(),
////      price: 190.79,
////    ),
////    WatchListItem(
////      symbol: 'TSLA',
////      price: 514.36,
////    ),
////    WatchListItem(
////      symbol: 'AMZN',
////      price: 1900.10,
////    )
////  ];



  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
    String uid;
    List<WatchListItem> watchListItems = [];
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((res) { // get current user
      print(res);
      if (res != null) {
        uid = res.uid;
        print("uid ${uid}");
      }
      else
      {
        print("error getting user id");
      }
    });
  }

  void updateWatchList() async {
    StockService stockService = new StockService();
    for (WatchListItem item in watchListItems) {
      String symbol = item.symbol;
      var stockData = await stockService.getStockQuoteBySymbol(symbol);
      double newPrice = double.parse(stockData['Global Quote']['05. price']);
      item.price = newPrice;
    }
    setState(() {
      // to update the numbers in our list
    });


  }

  @override
  Widget build(BuildContext context) {
//    return ListView(
//      children: widget.watchListItems,
//    );
   return StreamBuilder<DocumentSnapshot>(
     stream: Firestore.instance.collection('watchlists').document(uid).snapshots(), // hardcoded because getCurrentUser() doesn't work yet
     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
       if (snapshot.hasError) {
         return new Center(
           child: Text('Error: ${snapshot.error}'),
         );
       }
       if (!snapshot.hasData) {
         return new Center(
           child: CircularProgressIndicator(),
         );
       }
       else {
         var documents = snapshot.data.data; // get the data
         if (documents == null) {
           return new Center(
             child: Text("Add some stocks to your watchlist!"),
           );
         }
         var vals = documents.values; // values from data
         List symbols = vals.elementAt(0); // all our values are in an array on firestore called symbols which is at index 0

         for (int x = 0; x < symbols.length; x++) {
           watchListItems.add(
             WatchListItem(
               symbol: symbols.elementAt(x),
               price: 0.0,
             ),
           );
         }
         updateWatchList(); // call stock services to update our prices


         return new Center(
           child: ListView(
             children: watchListItems,
           ),
         );
       }
     },
   );
  }
}

