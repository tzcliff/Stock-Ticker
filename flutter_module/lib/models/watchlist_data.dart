import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/models/watchlist_item.dart';

class ModelData extends ChangeNotifier {
  List<WatchlistItem> _items = [
  ];
  UnmodifiableListView get items {
    return UnmodifiableListView(_items);
  }

  int get itemsCount {
    return _items.length;
  }

  void addItem(WatchlistItem item) {
    _items.add(item);
    notifyListeners();
  }

  void deleteItem(WatchlistItem item) {
    _items.remove(item);
    notifyListeners();
  }
}