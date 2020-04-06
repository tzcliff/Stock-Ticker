import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/components/watchlist_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermodule/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fluttermodule/screens/home_screen.dart';

  getUser() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return user.uid;
  }

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

  @override
  Widget build(BuildContext context) {
//    return ListView(
//      children: widget.watchListItems,
//    );
   return StreamBuilder<DocumentSnapshot>(
     stream: Firestore.instance.collection('watchlists').document('YL30RqPdpxbU8el2z1wm8ERywMY2').snapshots(),
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
         var documents = snapshot.data.data;
         var vals = documents.values;
         List<WatchListItem> watchListItems = [];
         for (int x = 0; x < vals.length; x++) {
           watchListItems.add(
             WatchListItem(
               symbol: vals.elementAt(x).toString(),
               price: 190.79,
             ),
           );
         }

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

