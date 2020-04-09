import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/components/watchlist_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermodule/models/stock.dart';
import 'package:fluttermodule/models/watchlist_stock.dart';
import 'package:fluttermodule/screens/home_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';
import 'package:provider/provider.dart';
import 'package:fluttermodule/models/watchlist_data.dart';

class WatchlistScreen extends StatefulWidget {
  static String id = 'watchlist_screen';

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  FirebaseUser loggedInUser;
  String uid;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<WatchListItem> watchListItems = [];

  @override
  void initState() {
    uid = HomeScreen.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('watchlists')
          .document(uid)
          .snapshots(), // getCurrentUser() works now
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return new Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData) {
          return new Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var documents = snapshot.data.data; // get the data

          // comment out as the documents are always null for some reason

          // if (documents == null) {

          //   print('no data');
          //   return new Center(
          //     child: Text("Add some stocks to your watchlist!"),
          //   );
          // }
          // var symbols = documents['symbols']; // values from data
          // print(symbols.length);
          // for (int x = 0; x < symbols.length; x++) {
          //   Provider.of<WatchlistData>(context, listen: false)
          //       .addItemIfNotExistBySymbol(symbols.elementAt(x));
          // }
          //updateWatchList(); // call stock services to update our prices
          return new Center(
            child: ListView.builder(
              itemCount: Provider.of<WatchlistData>(context).itemsCount,
              itemBuilder: (context, index) {
                final WatchlistStock stock =
                    Provider.of<WatchlistData>(context).items[index];
                return WatchListItem(
                  symbol: stock.symbol,
                  price: stock.price,
                );
              },
            ),
          );
        }
      },
    );
  }
}
