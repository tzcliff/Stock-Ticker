import 'package:flutter/material.dart';
import 'package:fluttermodule/models/stock.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';

class KLineModel {
  KLineModel(this.stock, {this.isShowCandleInfo});
  Stock stock;
  double priceMa1, priceMa2, priceMa3;
  double volumeMa1, volumeMa2;
  Offset offset;
  double candleWidgetOriginY, gridTotalHeight;
  bool isShowCandleInfo;
  List<String> candleInfo() {
    String date = stock.date;
    double open = double.parse(stock.open);
    double close = double.parse(stock.close);

    double limitUpDownAmount = close - open;
    double limitUpDownPercent = (limitUpDownAmount / open) * 100;
    String pre = '';
    if (limitUpDownAmount > 0) { pre = '+'; }
    String limitUpDownAmountStr = '$pre${limitUpDownAmount.toStringAsFixed(2)}';
    String limitPercentStr = '$pre${limitUpDownPercent.toStringAsFixed(2)}%';
    return [date, stock.open, stock.high, stock.low, stock.close, limitUpDownAmountStr, limitPercentStr, stock.volume];
  }
}