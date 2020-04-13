import 'package:flutter/cupertino.dart';
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
  int stockCounts;
  List<dynamic> finalResult=[];

  BackTester ({symbol, model, stockCounts = 1000}) {
    this.symbol = symbol;
    this.model = model;
    this.stockCounts = stockCounts;
  }


  Future<List<dynamic>> backTest() async{

    StockService stockService = StockService();
    stockList = await stockService.fetchStock(symbol);
    print(stockList.list.length);
    List<Conditional> conditionalList = model.conditionals;



    for (int c = 0; c < conditionalList.length; c++) {

      List tempResult = resultInOneConditional(conditionalList[c]);
      finalResult.add(tempResult);

      /*if (c == 0) {
        finalResult = tempResult;
      }*/


    }
    final commonDates = finalResult.fold<Set>(
        finalResult.first.toSet(),
            (a, b) => a.intersection(b.toSet()));





    return commonDates.toList();
  }

  List<dynamic> resultInOneConditional (Conditional conditional) {
    List<dynamic> result = [];

    StockItem stockItem = conditional.stockItem;
    Trend trend = conditional.trend;
    // double scope = firstConditional.scope;
    int duration = conditional.duration;

    String priceType = stockItem.toString().split('.').last;
    bool flag = true;
    List<Stock> normalStockList = stockList.list.reversed.toList();
    if (trend == Trend.increase) {
      for (int i = 0; i < stockList.list.length; i++) {
        if (i > normalStockList.length - 2 - duration) {
          break;
        }
        //print(normalStockList[i].date);
        //Stock stockOneday = stockList.list[i];
        int operatingDay;
        for (operatingDay = i + 1; operatingDay < i + duration + 1; operatingDay++) {
          //print(stockList.list[operatingDay].getData(priceType));
          if (double.parse(normalStockList[operatingDay].getData(priceType))  < double.parse(normalStockList[operatingDay-1].getData(priceType))) {
            flag = false;
            break;
          }
        }
        if (flag == true) {
          result.add(normalStockList[operatingDay].date);
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
        for (operatingDay = i + 1; operatingDay < i + duration + 1; operatingDay++) {
          //print(stockList.list[operatingDay].getData(priceType));
          if (double.parse(normalStockList[operatingDay].getData(priceType))  > double.parse(normalStockList[operatingDay-1].getData(priceType))) {
            flag = false;
            break;
          }
        }
        if (flag == true) {
          result.add(normalStockList[operatingDay].date);
        }
        flag = true;


      }
      //print(result);
    }

    return result;
  }


}