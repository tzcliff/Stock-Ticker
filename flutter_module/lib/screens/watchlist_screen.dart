import 'package:flutter/material.dart';
import 'package:fluttermodule/components/watchlist_item.dart';

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
  }
}
