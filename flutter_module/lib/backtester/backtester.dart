import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/components/backtesterResultListItem.dart';
import 'package:fluttermodule/models/conditional.dart';
import 'package:fluttermodule/models/enums.dart';
import 'package:fluttermodule/models/model.dart';
import 'package:fluttermodule/models/stock.dart';
import 'package:fluttermodule/screens/add_model_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';

class BackTester {
  String symbol;
  StockList stockList;
  Model model;
  List<Widget> finalResult = [];
  UserAction userAction;

  BackTester({symbol, model}) {
    this.symbol = symbol;
    this.model = model;
  }

  Future<List<dynamic>> backTest() async {
    StockService stockService = StockService();
    stockList = await stockService.fetchStock(symbol);
    print(stockList.list.length);
    List<Conditional> conditionalList = model.conditionals;
    userAction = model.action;

    for (int c = 0; c < conditionalList.length; c++) {
      List<Widget> tempResult = resultInOneConditional(conditionalList[c]);
      finalResult.addAll(tempResult);

      /*if (c == 0) {
        finalResult = tempResult;
      }*/

    }
    /*final commonDates = finalResult.fold<Set>(
        finalResult.first.toSet(),
            (a, b) => a.intersection(b.toSet()));*/

    return finalResult;
  }

  List<Widget> resultInOneConditional(Conditional conditional) {
    List<Widget> result = [];

    StockItem stockItem = conditional.stockItem;
    Trend trend = conditional.trend;
    // double scope = firstConditional.scope;
    int duration = conditional.duration;

    String priceType = stockItem.toString().split('.').last;
    bool flag = true;
    List<Stock> normalStockList = stockList.list.reversed.toList();
    if (trend == Trend.up) {
      for (int i = 0; i < stockList.list.length; i++) {
        if (i > normalStockList.length - 2 - duration) {
          break;
        }

        int operatingDay;
        for (operatingDay = i + 1;
            operatingDay < i + duration + 1;
            operatingDay++) {
          //print(stockList.list[operatingDay].getData(priceType));
          if (double.parse(normalStockList[operatingDay].getData(priceType)) <
              double.parse(
                  normalStockList[operatingDay - 1].getData(priceType))) {
            flag = false;
            break;
          }
        }
        if (flag == true) {
          String buyPrice = normalStockList[operatingDay].getData(priceType);
          String comparePrice =
              normalStockList[operatingDay + 1].getData(priceType);
          String whetherValid = measure(buyPrice, comparePrice, userAction);
          String date = normalStockList[operatingDay].date;
          result.add(resultItem(
              firstPrice: buyPrice,
              secondPrice: comparePrice,
              whetherValid: whetherValid,
              date: date));
        }
        flag = true;
      }
      //print(result);
    } else {
      for (int i = 0; i < stockList.list.length; i++) {
        if (i > normalStockList.length - 2 - duration) {
          break;
        }
        int operatingDay;
        for (operatingDay = i + 1;
            operatingDay < i + duration + 1;
            operatingDay++) {
          //print(stockList.list[operatingDay].getData(priceType));
          if (double.parse(normalStockList[operatingDay].getData(priceType)) >
              double.parse(
                  normalStockList[operatingDay - 1].getData(priceType))) {
            flag = false;
            break;
          }
        }
        if (flag == true) {
          String buyPrice = normalStockList[operatingDay].getData(priceType);
          String comparePrice =
              normalStockList[operatingDay + 1].getData(priceType);
          String whetherValid = measure(buyPrice, comparePrice, userAction);
          String date = normalStockList[operatingDay].date;
          result.add(resultItem(
              firstPrice: buyPrice,
              secondPrice: comparePrice,
              whetherValid: whetherValid,
              date: date));
        }
        flag = true;
      }
      //print(result);
    }

    return result;
  }

  String measure(String firstPrice, String secondPrice, UserAction userAction) {
    if (userAction == UserAction.buy) {
      if (double.parse(secondPrice) > double.parse(firstPrice)) {
        return 'valid';
      } else {
        return 'invalid';
      }
    } else {
      if (double.parse(secondPrice) > double.parse(firstPrice)) {
        return 'invalid';
      } else {
        return 'valid';
      }
    }
  }
}
