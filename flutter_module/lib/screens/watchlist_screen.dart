import 'package:flutter/material.dart';

class WatchlistScreen extends StatefulWidget {
  static String id = 'watchlist_screen';
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('WatchList'));
  }
}
