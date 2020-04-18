import 'package:flutter/foundation.dart';

import 'enums.dart';

class Conditional {
  StockItem stockItem = StockItem.close;
  Trend trend = Trend.up;
  double scope = 10.0;
  int std = 1;
  int duration = 2;
  Conditional({
    @required this.stockItem,
    @required this.trend,
    @required this.scope,
    @required this.std,
    @required this.duration,
  });
}
