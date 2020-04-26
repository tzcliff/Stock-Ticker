import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';

class KlineCandleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KlineBloc bloc = KlineBlocProvider.of<KlineBloc>(context);
    return StreamBuilder(
      stream: bloc.currentKlineListStream,
      builder: (BuildContext context, AsyncSnapshot<List<KLineModel>> snapshot) {
        return CustomPaint(
          key: bloc.candleWidgetKey,
          size: Size(bloc.screenWidth, bloc.screenWidth / kCandleAspectRatio),
          painter: _CandlePainter(
              listData: snapshot.data,
              priceMax: bloc.priceMax,
              priceMin: bloc.priceMin,
              pMax: bloc.pMax,
              pMin: bloc.pMin,
              candlestickWidth: bloc.candlestickWidth),
        );
      },
    );
  }
}

class _CandlePainter extends CustomPainter {
  _CandlePainter({
    @required this.listData,
    @required this.priceMax,
    @required this.priceMin,
    @required this.pMax,
    @required this.pMin,
    @required this.candlestickWidth,
  });
  final List<KLineModel> listData;
  final double priceMax;
  final double priceMin;
  final double pMax;
  final double pMin;

  final double candlestickWidth;
  final double wickWidth = kWickWidth;
  final double candlestickGap = kCandlestickGap;
  final double topMargin = kTopMargin + kCandleTextHeight / 2;
  final Color increaseColor = kIncreaseColor;
  final Color decreaseColor = kDecreaseColor;
  final double candleTextHeight = kCandleTextHeight;

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.black
      ..blendMode = BlendMode.colorBurn
      ..strokeWidth = 0.5;
    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), linePaint);
    if (listData == null || priceMax == null || priceMin == null) { return; }
    double height = size.height - topMargin - kCandleTextHeight / 2;
    double heightPriceOffset = 0;
    if ((priceMax - priceMin) != 0) { heightPriceOffset = height / (priceMax - priceMin); }
    double candlestickLeft;
    double candlestickTop;
    double candlestickRight;
    double candlestickBottom;
    Paint candlestickPaint;
    bool maxPricePainted = false;
    bool minPricePainted = false;
    for (int i = 0; i < listData.length; i++) {
      KLineModel klinemodel = listData[i];

      Color painterColor;
      PaintingStyle paintingStyle;
      if (double.parse(klinemodel.stock.open) > double.parse(klinemodel.stock.close)) {
        painterColor = decreaseColor;
        paintingStyle = PaintingStyle.fill;
      } else if (double.parse(klinemodel.stock.open) == double.parse(klinemodel.stock.close)) {
        painterColor = Colors.white;
        paintingStyle = PaintingStyle.fill;
      } else {
        painterColor = increaseColor;
        paintingStyle = PaintingStyle.fill;
      }
      candlestickPaint = Paint()
        ..color = painterColor
        ..strokeWidth = wickWidth
        ..isAntiAlias = true
        ..filterQuality = FilterQuality.high
        ..style = paintingStyle;
      
      int j = listData.length - 1 - i;
      candlestickLeft = j * (candlestickWidth + candlestickGap) + candlestickGap;
      candlestickRight = candlestickLeft + candlestickWidth;
      candlestickTop = height - (double.parse(klinemodel.stock.open) - priceMin) * heightPriceOffset + topMargin;
      candlestickBottom = height - (double.parse(klinemodel.stock.close) - priceMin) * heightPriceOffset + topMargin;

      Rect candlestickRect = Rect.fromLTRB(candlestickLeft, candlestickTop, candlestickRight, candlestickBottom);
      canvas.drawRect(candlestickRect, candlestickPaint);
      
      double low = height - (double.parse(klinemodel.stock.low) - priceMin) * heightPriceOffset + topMargin;
      double high = height - (double.parse(klinemodel.stock.high) - priceMin) * heightPriceOffset + topMargin;
      double candlestickCenterX = candlestickLeft + candlestickWidth.ceilToDouble() / 2.0;
      double closeOffsetY = height - (double.parse(klinemodel.stock.close) - priceMin) * heightPriceOffset + topMargin;
      klinemodel.offset = Offset(candlestickCenterX, closeOffsetY);
      Offset highBottomOffset = Offset(candlestickCenterX, candlestickTop);
      Offset highTopOffset = Offset(candlestickCenterX, high);
      Offset lowBottomOffset = Offset(candlestickCenterX, candlestickBottom);
      Offset lowTopOffset = Offset(candlestickCenterX, low);
      canvas.drawLine(highBottomOffset, highTopOffset, candlestickPaint);
      canvas.drawLine(lowBottomOffset, lowTopOffset, candlestickPaint);

      Paint pricePaint = Paint()
        ..color = kCandleTextColor
        ..strokeWidth = 1;

      double lineWidth = 10;
      bool isLeft = false;
      double textOriginX;
      if (candlestickCenterX < size.width / 2) {
        textOriginX = candlestickCenterX + lineWidth;
        isLeft = true;
      } else {
        textOriginX = candlestickCenterX - lineWidth;
        isLeft = false;
      }
      if (double.parse(klinemodel.stock.high) == pMax && !maxPricePainted) {
        canvas.drawLine(Offset(candlestickCenterX, high), Offset(textOriginX, high), pricePaint);
        _drawText(canvas, Offset(textOriginX, high - kCandleTextHeight / 2), klinemodel.stock.high, isLeft);
        maxPricePainted = true;
      }
      if (double.parse(klinemodel.stock.low) == pMin && !minPricePainted) {
        canvas.drawLine(Offset(candlestickCenterX, low), Offset(textOriginX, low), pricePaint);
        _drawText(canvas, Offset(textOriginX, low - kCandleTextHeight / 2), klinemodel.stock.low, isLeft);
        minPricePainted = true;
      }
    }
  }

  _drawText(Canvas canvas, Offset offset, String text, bool isLeft) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: kCandleTextColor,
            fontSize: kCandleFontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    Offset of = offset;
    if (!isLeft) { of = Offset(offset.dx - textPainter.width, offset.dy); }
    textPainter.paint(canvas, of);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) { return listData != null; }
}