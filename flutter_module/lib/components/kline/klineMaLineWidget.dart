import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';

class KlineMaLineWidget extends StatelessWidget {
  final YKMAType maType;
  KlineMaLineWidget(this.maType);
  @override
  Widget build(BuildContext context) {
    KlineBloc bloc = KlineBlocProvider.of<KlineBloc>(context);
    return StreamBuilder(
      stream: bloc.currentKlineListStream,
      builder: (BuildContext context, AsyncSnapshot<List<KLineModel>> snapshot) {
        List<KLineModel> listData;
        if (snapshot.data != null) {
          listData = snapshot.data;
        }
        return CustomPaint(
          size: Size(bloc.screenWidth, bloc.screenWidth / kCandleAspectRatio),
          painter: _KlineMaLinePainter(listData, maType, bloc.priceMax,
              bloc.priceMin, bloc.candlestickWidth),
        );
      },
    );
  }
}

class _KlineMaLinePainter extends CustomPainter {
  _KlineMaLinePainter(this.listData, this.maType, this.priceMax, this.priceMin, this.candlestickWidth);
  final List<KLineModel> listData;
  final YKMAType maType;
  final double priceMax;
  final double priceMin;
  final double candlestickWidth;
  final double lineWidth = kMaLineWidth;
  final double topMargin = kMaTopMargin;
  final double candlestickGap = kCandlestickGap;
  Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (listData == null || priceMax == null || priceMin == null || maType == null) { return; }
    double height = size.height - topMargin;
    double heightPriceOffset = 0;
    if (priceMax - priceMin != 0) { heightPriceOffset = height / (priceMax - priceMin); }

    for (int i = 0; i < listData.length; i++) {
      if (i == listData.length - 1) { break; }
      KLineModel klinemodel = listData[i];
      KLineModel nextmodel = listData[i + 1];
      if ((klinemodel.priceMa1 == null && maType == YKMAType.MA5) ||
          (klinemodel.priceMa2 == null && maType == YKMAType.MA10) ||
          (klinemodel.priceMa3 == null && maType == YKMAType.MA30)) { break; }
      double currentMaPrice;
      double currentNextMaPrice;

      switch (maType) {
        case YKMAType.MA5:
          {
            lineColor = kMa5LineColor;
            currentMaPrice = klinemodel.priceMa1;
            currentNextMaPrice = nextmodel.priceMa1;
          }
          break;
        case YKMAType.MA10:
          {
            lineColor = kMa10LineColor;
            currentMaPrice = klinemodel.priceMa2;
            currentNextMaPrice = nextmodel.priceMa2;
          }
          break;
        case YKMAType.MA30:
          {
            lineColor = kMa20LineColor;
            currentMaPrice = klinemodel.priceMa3;
            currentNextMaPrice = nextmodel.priceMa3;
          }
          break;
        default:
      }

      Paint maPainter = Paint()
        ..color = lineColor
        ..isAntiAlias = true
        ..filterQuality = FilterQuality.high
        ..strokeWidth = lineWidth;

      double startX, startY, endX, endY;
      int j = listData.length - 1 - i;

      double startRectLeft = j * (candlestickWidth + candlestickGap) + candlestickGap;
      double endRectLeft = (j - 1) * (candlestickWidth + candlestickGap) + candlestickGap;
      startX = startRectLeft + candlestickWidth / 2;
      endX = endRectLeft + candlestickWidth / 2;
      
      if (currentMaPrice != null && currentNextMaPrice != null) {
        startY = height - (currentMaPrice - priceMin) * heightPriceOffset + topMargin;
        endY = height - (currentNextMaPrice - priceMin) * heightPriceOffset + topMargin;
        canvas.drawLine(Offset(startX, startY), Offset(endX, endY), maPainter);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return listData != null;
  }
}