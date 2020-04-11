import 'package:flutter/foundation.dart';

import 'enums.dart';

class Conditional {
  StockItem stockItem = StockItem.close;
  Trend trend = Trend.increase;
  double scope = 10.0;
  int duration = 2;
  Conditional({
    @required this.stockItem,
    @required this.trend,
    @required this.scope,
    @required this.duration,
  });
}
