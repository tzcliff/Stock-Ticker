import 'package:fluttermodule/services/network_service.dart';
import 'package:fluttermodule/api_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/kline/klinepagewidget.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttermodule/models/stock.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:http/http.dart' as http;

class KLineScreen extends StatefulWidget {
  KLineScreen({Key key, this.symbol}) : super(key: key);
  final String symbol;

  @override
  _KLineScreen createState() => _KLineScreen();
}

class _KLineScreen extends State<KLineScreen> {
  @override
  Widget build(BuildContext context) {
    KlinePageBloc bloc = KlinePageBloc(widget.symbol);
    return Scaffold(
        body: Center(
          child: FloatingActionButton(
            child: Icon(Icons.input),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return Scaffold(
                    appBar: CupertinoNavigationBar(
                      padding: EdgeInsetsDirectional.only(start: 0),
                      leading: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Icon(Icons.arrow_back,color: Colors.white,),
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      middle: Text(widget.symbol, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Baloo2', color: Colors.white),),
                      backgroundColor: kBackgroundColor,
                    ),
                    body: Container(
                      color: kBackgroundColor,
                      child: ListView(
                        children: <Widget>[
                          KlinePageWidget(bloc),
                        ],
                      ),
                    ));
              }));
            },
          ),
        ));
  }
}

Future<StockList> fetchStock(String period, String symbol) async {
  // a future is a Dart class for async operations, a future represents a potential value OR error that will be available at some future time
  if (period == '1day') {
    NetworkService networkService = NetworkService(
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=' +
            symbol +
            '&apikey=' +
            kAlphaStockAPIKey);

    var data = await networkService.getDataListFormat();
    if (data != null) {
      // double check the data one last time
      return data;
      // return StockList.fromJson(json.decode(response.body));
    } else {
      // If the data isn't there for some reason (i.e. not a 200 response code)
      throw Exception('Failed to load stock');
    }
  }

  var url = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' +
      symbol +
      '&interval=' +
      period +
      '&apikey=' +
      kAlphaStockAPIKey;

  var response = await http.get(url);
  if (response.statusCode == 200) {
    return StockList.fromJsonWithPeriod(json.decode(response.body), period);
  }
  else {
    print(response.statusCode);
    return null;
  }
}

class KlinePageBloc extends KlineBloc {
  KlinePageBloc(this.symbol);
  final String symbol;

  @override
  void periodSwitch(String period) {
    _getData(period, symbol);
    super.periodSwitch(period);
  }

  @override
  void initData() {
    _getData('1day', symbol);
    super.initData();
  }

  _getData(String period, String symbol) {
    this.showLoadingSinkAdd(true);
    Future<StockList> futureStock = fetchStock(period, symbol);
    futureStock.then((stockList) {
      List<KLineModel> list = List<KLineModel>();
      for (Stock stock in stockList.list) {
        KLineModel klinemodel = KLineModel(stock);
        list.add(klinemodel);
      }
      this.showLoadingSinkAdd(false);
      this.updateDataList(list);
    });
  }
}