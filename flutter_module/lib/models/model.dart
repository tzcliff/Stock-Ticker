import 'package:flutter/foundation.dart';

import 'conditional.dart';
import 'enums.dart';

class Model {
  String name;
  List<Conditional> conditionals = [];
  UserAction action = UserAction.buy;

  Model({
    @required this.name,
    @required this.conditionals,
    @required this.action,
  });
}
