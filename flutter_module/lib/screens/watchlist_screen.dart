import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/components/watchlist_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermodule/services/database.dart';
import 'package:provider/provider.dart';

   Future getUser() async {
     var document = await Firestore.instance.document('watchlists/YL30RqPdpxbU8el2z1wm8ERywMY2').get();
     var snapshots = document.toString();
  }
  

class WatchlistScreen extends StatefulWidget {
  static String id = 'watchlist_screen';
  List<WatchListItem> watchListItems = [
    WatchListItem(
      symbol: 'FB',
      price: 156.79,
    ),
    WatchListItem(
      symbol: 'TSLA',
      price: 514.36,
    ),
    WatchListItem(
      symbol: 'AMZN',
      price: 1900.10,
    )
  ];

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.watchListItems,
    );
//    return StreamProvider<QuerySnapshot>.value(
//      value: DatabaseService().watchlist,
//      child: ListView(
//        children: widget.watchListItems,
//      ),
//    );
  }
}

