import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/components/backtesterResultListItem.dart';
import 'package:fluttermodule/models/conditional.dart';
import 'package:fluttermodule/models/enums.dart';
import 'package:fluttermodule/models/model.dart';
import 'package:fluttermodule/models/stock.dart';
import 'package:fluttermodule/screens/add_model_screen.dart';
import 'package:fluttermodule/services/stock_service.dart';
import 'dart:math';

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
    stockList = await stockService.fetchStockFull(symbol);
    print('jiang' + stockList.list.length.toString());
    List<Conditional> conditionalList = model.conditionals;
    userAction = model.action;

    for (int c = 0; c < conditionalList.length; c++) {
      List<Widget> tempResult =
          await resultInOneConditional(conditionalList[c]);
      print('temp:' + tempResult.length.toString());
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

  Future<List<Widget>> resultInOneConditional(Conditional conditional) async {
    List<Widget> result = [];
    StockItem stockItem = conditional.stockItem;
    Trend trend = conditional.trend;
    // double scope = firstConditional.scope;
    int duration = conditional.duration;
    double numberSTD = conditional.std;

    String priceType = stockItem.toString().split('.').last;
    bool flag = true;

    List<Stock> normalStockList = stockList.list.reversed.toList();
    double std = stdCaculate(
        average(normalStockList, priceType), normalStockList, priceType);

    if (trend == Trend.up) {
      for (int i = 0; i < stockList.list.length; i++) {
        if (i > normalStockList.length - 3 - duration) {
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
        if ((double.parse(normalStockList[operatingDay].getData(priceType)) -
                double.parse(normalStockList[i].getData(priceType))) <
            numberSTD * std) {
          flag = false;
        }
        if (flag == true) {
          String buyPrice = normalStockList[operatingDay].getData(priceType);
          String comparePrice =
              normalStockList[operatingDay + 1].getData(priceType);
          String whetherValid = measure(buyPrice, comparePrice, userAction);
          String date = normalStockList[operatingDay].date;
          result.add(ResultItem(
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
        if (i > normalStockList.length - 3 - duration) {
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
        if ((double.parse(normalStockList[i].getData(priceType)) -
                double.parse(
                    normalStockList[operatingDay].getData(priceType))) <
            numberSTD * std) {
          flag = false;
        }
        if (flag == true) {
          String buyPrice = normalStockList[operatingDay].getData(priceType);
          String comparePrice =
              normalStockList[operatingDay + 1].getData(priceType);
          String whetherValid = measure(buyPrice, comparePrice, userAction);
          String date = normalStockList[operatingDay].date;
          result.add(ResultItem(
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

  double average(List<Stock> stocklist, String priceType) {
    double sum = 0;
    for (int i = 0; i < stocklist.length; i++) {
      sum += double.parse(stocklist[i].getData(priceType));
    }
    return sum / stocklist.length;
  }

  double stdCaculate(double avg, List<Stock> stocklist, String priceType) {
    double sum = 0;
    for (int i = 0; i < stocklist.length; i++) {
      sum += pow(double.parse(stocklist[i].getData(priceType)) - avg, 2);
    }
    return sqrt(sum / stocklist.length);
  }
}
