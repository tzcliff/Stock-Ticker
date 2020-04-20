import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/models/conditional.dart';
import 'package:fluttermodule/models/enums.dart';
import 'package:fluttermodule/models/model.dart';

class ModelData extends ChangeNotifier {
  List<Model> _models = [
    Model(name: 'Model 1', action: UserAction.buy, conditionals: [
      Conditional(
          stockItem: StockItem.close,
          trend: Trend.down,
          scope: 10,
          duration: 4,
          std: 0.1)
    ]),
    Model(name: 'Model 2', action: UserAction.sell, conditionals: [
      Conditional(
          stockItem: StockItem.open,
          trend: Trend.down,
          scope: 10,
          duration: 3,
          std: 2),
      Conditional(
          stockItem: StockItem.close,
          trend: Trend.down,
          scope: 10,
          duration: 4,
          std: 0.1)
    ]),
    Model(name: 'Model 3', action: UserAction.buy, conditionals: [
      Conditional(
          stockItem: StockItem.high,
          trend: Trend.up,
          scope: 10,
          duration: 4,
          std: 1),
      Conditional(
          stockItem: StockItem.high,
          trend: Trend.up,
          scope: 10,
          duration: 4,
          std: 0.1),
    ]),
  ];
  UnmodifiableListView<Model> get models {
    return UnmodifiableListView<Model>(_models);
  }

  int get modelsCount {
    return _models.length;
  }

  void addModel(Model model) {
    _models.add(model);
    notifyListeners();
  }

  void deleteModel(Model model) {
    _models.remove(model);
    notifyListeners();
  }
}
