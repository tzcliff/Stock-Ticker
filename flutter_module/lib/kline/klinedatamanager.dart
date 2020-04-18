import 'package:fluttermodule/kline/klinemodel.dart';

enum YKChartType { Unknown, MA, VOL }

class KlineDataManager {
  static final List<int> priceMaList = [5, 10, 30];
  static final List<int> volumeMaList = [5, 10];
  static List<KLineModel> calculateKlineData(
      YKChartType type, List<KLineModel> dataList) {
    switch (type) {
      case YKChartType.MA:
        return _calculatePriceMa(dataList);
      case YKChartType.VOL:
        return _calculateVolumeMa(dataList);
      default:
        return dataList;
    }
  }

  static List<KLineModel> _calculatePriceMa(List<KLineModel> dataList) {
    List<KLineModel> tmpList = dataList;
    for (int numIndex = 0; numIndex < priceMaList.length; numIndex++) {
      int maNum = priceMaList[numIndex];
      if (maNum <= 0) { return tmpList; }
      int listCount = tmpList.length;
      for (int i = tmpList.length - 1; i >= 0; i --) {
        KLineModel klinemodel = tmpList[i];
        if ((numIndex == 0 && klinemodel.priceMa1 != null) ||
            (numIndex == 0 && klinemodel.priceMa2 != null) ||
            (numIndex == 0 && klinemodel.priceMa3 != null)) {
          return tmpList;
        }

        if (i <= tmpList.length - maNum) {
          KLineModel lastData;
          if (i < tmpList.length - 1) { lastData = tmpList[i + 1]; }
          double lastMa;
          if (lastData != null) {
            switch (numIndex) {
              case 0:
                lastMa = lastData.priceMa1;
                break;
              case 1:
                lastMa = lastData.priceMa2;
                break;
              case 2:
                lastMa = lastData.priceMa3;
                break;
              default:
                break;
            }
          }
          double priceMa = 0;
          if (lastMa != null) {
            KLineModel deleteData = tmpList[i + maNum];
            priceMa = lastMa * maNum + double.parse(klinemodel.stock.close) - double.parse(deleteData.stock.close);
          } else {
            List<KLineModel> aveArray = tmpList.sublist(i, listCount);
            for (var tmpData in aveArray) {
              priceMa += double.parse(tmpData.stock.close);
            }
          }
          priceMa = priceMa / maNum;
          switch (numIndex) {
            case 0:
              tmpList[i].priceMa1 = priceMa;
              break;
            case 1:
              tmpList[i].priceMa2 = priceMa;
              break;
            case 2:
              tmpList[i].priceMa3 = priceMa;
              break;
            default:
              break;
          }
        }
      }
    }
    return tmpList;
  }

  static List<KLineModel> _calculateVolumeMa(List<KLineModel> dataList) {
    List<KLineModel> tmpList = dataList;
    for (int numIndex = 0; numIndex < volumeMaList.length; numIndex++) {
      int maNum = volumeMaList[numIndex];
      if (maNum <= 0) { return tmpList; }
      int listCount = tmpList.length;
      for (int i = tmpList.length - 1; i >= 0; i --) {
        KLineModel klinemodel = tmpList[i];
        if ((numIndex == 0 && klinemodel.volumeMa1 != null) ||(numIndex == 0 && klinemodel.volumeMa2 != null)) { return tmpList; }
        if (i <= tmpList.length - maNum) {
          KLineModel lastData;
          if (i < tmpList.length - 1) { lastData = tmpList[i + 1]; }
          double lastMa;
          if (lastData != null) {
            switch (numIndex) {
              case 0:
                lastMa = lastData.volumeMa1;
                break;
              case 1:
                lastMa = lastData.volumeMa2;
                break;
              default:
                break;
            }
          }
          double volumeMa = 0;
          if (lastMa != null) {
            KLineModel deleteData = tmpList[i + maNum];
            volumeMa = lastMa * maNum + double.parse(klinemodel.stock.volume) - double.parse(deleteData.stock.volume);
          } else {
            List<KLineModel> aveArray = tmpList.sublist(i, listCount);
            for (var tmpData in aveArray) {
              volumeMa += double.parse(tmpData.stock.close);
            }
          }
          volumeMa = volumeMa / maNum;
          switch (numIndex) {
            case 0:
              tmpList[i].volumeMa1 = volumeMa;
              break;
            case 1:
              tmpList[i].volumeMa2 = volumeMa;
              break;
            default:
              break;
          }
        }
      }
    }
    return tmpList;
  }
}