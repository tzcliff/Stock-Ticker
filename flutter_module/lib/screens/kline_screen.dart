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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Kline Demo',
      home: MyHomePage(title: 'Kline Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    KlinePageBloc bloc = KlinePageBloc();
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text(widget.title),
        ),
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
                      middle: Text('BTC-USDT', style: TextStyle(color: Colors.white),),
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

Future<String> loadAsset() async {
  return await rootBundle.loadString('json/btcusdt.json');
}

Future<StockList> getIPAddress(String period) async {
  if (period == null) { period = '1day'; }
  var url = 'https://api.huobi.io/market/history/kline?period=$period&size=449&symbol=btcusdt';
  StockList result;
  var response = await http.get(url);
  if (response.statusCode == HttpStatus.ok) { result = response.body; }
  else { print('Failed getting IP address'); }
  return result;
}

class KlinePageBloc extends KlineBloc {
  @override
  void periodSwitch(String period) {
    _getData(period);
    super.periodSwitch(period);
  }

  @override
  void initData() {
    _getData('1day');
    super.initData();
  }

  _getData(String period) {
    this.showLoadingSinkAdd(true);
    Future<StockList> futureStock = getIPAddress('$period');
    futureStock.then((result) {
      final parseJson = json.decode(result);
      StockList stockList = StockList.fromJson(parseJson);
      List<KLineModel> list = List<KLineModel>();
      for (Stock stock in stockList.data) {
        KLineModel market = KLineModel(stock);
        list.add(market);
      }
      this.showLoadingSinkAdd(false);
      this.updateDataList(list);
    });
  }
}