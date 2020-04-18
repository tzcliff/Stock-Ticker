import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klinedatamanager.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';
import 'package:rxdart/rxdart.dart';

class KlineBloc extends KlineBlocBase {
  BehaviorSubject<List<KLineModel>> _klineListSubject =
  BehaviorSubject<List<KLineModel>>();
  Sink<List<KLineModel>> get _klineListSink => _klineListSubject.sink;
  Stream<List<KLineModel>> get klineListStream => _klineListSubject.stream;
  
  PublishSubject<List<KLineModel>> _klineCurrentListSubject =
  PublishSubject<List<KLineModel>>();
  Sink<List<KLineModel>> get _currentKlineListSink => _klineCurrentListSubject.sink;
  Stream<List<KLineModel>> get currentKlineListStream =>
      _klineCurrentListSubject.stream;
  
  PublishSubject<KLineModel> _klineMarketSubject = PublishSubject<KLineModel>();
  Sink<KLineModel> get _klineMarketSink => _klineMarketSubject.sink;
  Stream<KLineModel> get klineMarketStream => _klineMarketSubject.stream;
  
  PublishSubject<String> _klinePeriodSwitchSubject = PublishSubject<String>();
  Sink<String> get _klinePeriodSwitchSink => _klinePeriodSwitchSubject.sink;
  Stream<String> get _klinePeriodSwitchStream => _klinePeriodSwitchSubject.stream;
  
  PublishSubject<bool> _klineShowLoadingSubject = PublishSubject<bool>();
  Sink<bool> get _klineShowLoadingSink => _klineShowLoadingSubject.sink;
  Stream<bool> get klineShowLoadingStream => _klineShowLoadingSubject.stream;
  
  List<KLineModel> klineCurrentList = List();
  List<KLineModel> klineTotalList = List();

  double screenWidth = 375;
  double priceMax;
  double priceMin;

  double pMax;
  double pMin;

  double volumeMax;
  int firstScreenCandleCount;
  double candlestickWidth = kCandlestickWidth;

  GlobalKey candleWidgetKey = GlobalKey();
  GlobalKey volumeWidgetKey = GlobalKey();
  
  int fromIndex;
  int toIndex;

  KlineBloc() {
    initData();
    _klinePeriodSwitchStream.listen(periodSwitch);
  }
  void periodSwitch(String period) {}
  void initData() {}

  @override
  void dispose() {
    _klineListSubject.close();
    _klineCurrentListSubject.close();
    _klineMarketSubject.close();
    _klinePeriodSwitchSubject.close();
    _klineShowLoadingSubject.close();
  }

  void updateDataList(List<KLineModel> dataList) {
    if (dataList != null && dataList.length > 0) {
      klineTotalList.clear();
      klineTotalList =
          KlineDataManager.calculateKlineData(YKChartType.MA, dataList);
      _klineListSink.add(klineTotalList);
    }
  }

  void setCandlestickWidth(double scaleWidth) {
    if (scaleWidth > 25 || scaleWidth < 2) {
      return;
    }
    candlestickWidth = scaleWidth;
  }

  int getSingleScreenCandleCount(double width) {
    screenWidth = width;
    double count =
        (screenWidth - kCandlestickGap) / (candlestickWidth + kCandlestickGap);
    int totalScreenCountNum = count.toInt();
    return totalScreenCountNum;
  }

  double getFirstScreenScale() {
    return (kGridColumnCount - 1) / kGridColumnCount;
  }

  void setScreenWidth(double width) {
    screenWidth = width;
    int singleScreenCandleCount = getSingleScreenCandleCount(screenWidth);
    int maxCount = this.klineTotalList.length;
    int firstScreenNum =
    (getFirstScreenScale() * singleScreenCandleCount).toInt();
    if (singleScreenCandleCount > maxCount) {
      firstScreenNum = maxCount;
    }
    firstScreenCandleCount = firstScreenNum;

    getSubKlineList(0, firstScreenCandleCount);
  }

  void getSubKlineList(int from, int to) {
    fromIndex = from;
    toIndex = to;
    List<KLineModel> list = this.klineTotalList;
    klineCurrentList.clear();
    klineCurrentList = list.sublist(from, to);
    _calculateCurrentKlineDataLimit();
    _currentKlineListSink.add(klineCurrentList);
  }

  void _calculateCurrentKlineDataLimit() {
    double _priceMax = -double.infinity;
    double _priceMin = double.infinity;
    double _pMax = -double.infinity;
    double _pMin = double.infinity;
    double _volumeMax = -double.infinity;
    for (var item in klineCurrentList) {
      _volumeMax = max(double.parse(item.stock.volume), _volumeMax);

      _priceMax = max(_priceMax, double.parse(item.stock.high));
      _priceMin = min(_priceMin, double.parse(item.stock.low));

      _pMax = max(_pMax, double.parse(item.stock.high));
      _pMin = min(_pMin, double.parse(item.stock.low));
      
      if (item.priceMa1 != null) {
        _priceMax = max(_priceMax, item.priceMa1);
        _priceMin = min(_priceMin, item.priceMa1);
      }
      if (item.priceMa2 != null) {
        _priceMax = max(_priceMax, item.priceMa2);
        _priceMin = min(_priceMin, item.priceMa2);
      }
      if (item.priceMa3 != null) {
        _priceMax = max(_priceMax, item.priceMa3);
        _priceMin = min(_priceMin, item.priceMa3);
      }
      pMax = _pMax;
      pMin = _pMin;
      priceMax = _priceMax;
      priceMin = _priceMin;
      volumeMax = _volumeMax;
    }
  }

  void marketSinkAdd(KLineModel market) {
    if (market != null) { _klineMarketSink.add(market); }
  }
  void periodSwitchSinkAdd(String period) {
    if (period != null) { _klinePeriodSwitchSink.add(period); }
  }

  void showLoadingSinkAdd(bool show) { _klineShowLoadingSink.add(show); }
}