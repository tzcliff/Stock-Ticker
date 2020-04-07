import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/models/watchlist_stock.dart';

class WatchlistData extends ChangeNotifier {
  List<WatchlistStock> _items = [];
  UnmodifiableListView get items {
    return UnmodifiableListView(_items);
  }

  int get itemsCount {
    return _items.length;
  }

  void addItem(WatchlistStock item) {
    _items.add(item);
    notifyListeners();
  }

  void deleteItem(WatchlistStock item) {
    _items.remove(item);
    notifyListeners();
  }

  bool addItemIfNotExistBySymbol({@required String symbol, double price = 0}) {
    for (WatchlistStock stock in items) {
      if (stock.symbol == symbol) {
        return false;
      }
    }
    _items.add(WatchlistStock(symbol: symbol, price: price));
    notifyListeners();
    return true;
  }
}
