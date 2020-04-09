import 'package:flutter/foundation.dart';

import 'enums.dart';

class Conditional {
  StockItem stockItem = StockItem.price;
  Trend trend = Trend.increase;
  double scope = 10.0;
  int dayPeriod = 2;
  Conditional({
    @required this.stockItem,
    @required this.trend,
    @required this.scope,
    @required this.dayPeriod,
  });
}
