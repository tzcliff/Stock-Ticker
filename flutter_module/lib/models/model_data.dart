import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/models/enums.dart';
import 'package:fluttermodule/models/model.dart';

class ModelData extends ChangeNotifier {
  List<Model> _models = [
    Model(name: 'Model 1', action: UserAction.buy, conditionals: []),
    Model(name: 'Model 2', action: UserAction.sell, conditionals: []),
    Model(name: 'Model 3', action: UserAction.sell, conditionals: []),
  ];
  UnmodifiableListView get models {
    return UnmodifiableListView(_models);
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
